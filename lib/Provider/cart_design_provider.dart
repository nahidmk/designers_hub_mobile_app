
import 'dart:convert';

import 'package:designers_hub_modile_app/Model/cart.dart';
import 'package:designers_hub_modile_app/Model/cart_details.dart';
import 'package:designers_hub_modile_app/Model/delivery_address.dart';
import 'package:designers_hub_modile_app/Model/promo.dart';
import 'package:designers_hub_modile_app/Service/oder_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartDesignProvider extends ChangeNotifier {

  OrderService get orderService => GetIt.I<OrderService>();

  Cart _cart = Cart(
    id: 0,
    discount: 0,
    finalPrice: 0,
    cartDetailsList: [],
    grandTotal: 0,
    totalPrice: 0,
    printingCost: 0,
    totalProducts: 0,
    promo: Promo(code: ""),
  );

  CartDesignProvider(){
    _loadCart();
  }

  void _loadCart() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? cartString = pref.getString('cart');
    if(cartString != null){
      cart = Cart.fromJson(json.decode(cartString));
    }
  }

  bool _loadingUpdateCart = false;


  bool get loadingUpdateCart => _loadingUpdateCart;

  set loadingUpdateCart(bool value) {
    _loadingUpdateCart = value;
    notifyListeners();
  }

  Cart get cart => _cart;
  bool _loadingOrder = false;


  bool get loadingOrder => _loadingOrder;

  set loadingOrder(bool value) {
    _loadingOrder = value;
    notifyListeners();
  }

  set cart(Cart value) {
    _cart = value;
    notifyListeners();
  }

  void deleteDesign(int id){
    _cart.cartDetailsList.removeWhere((element) => element.design.id==id);
    calculateTotalPrice();
  }

  void calculateTotalPrice() async{
    double totalPrice =0;

    for(int i =0;i<cart.cartDetailsList.length;i++){
      CartDetails cartDetails = cart.cartDetailsList[i];
      if(cartDetails.design.designType.requiredFabric){
        totalPrice += cart.cartDetailsList[i].design.price +(cartDetails.fabric.price*cartDetails.quantity);
      }else{
        totalPrice += cartDetails.design.price*cartDetails.quantity;
      }

    }
    _cart.totalPrice = totalPrice;
    cart = _cart;
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('cart', json.encode(cart.toJson()));
  }

  void addToCart(CartDetails cartDetails, double quantity){

    final exist = _cart.cartDetailsList.where((element) => element.design.id==cartDetails.design.id);

    if(exist.isNotEmpty){
      _cart.cartDetailsList = _cart.cartDetailsList.map((e) {
        if(e.design.id==cartDetails.design.id){
          e.quantity = quantity;
        }
        return e;
      }).toList();
    }else{
      cartDetails.quantity = quantity;
      _cart.cartDetailsList.add(cartDetails);
    }
    calculateTotalPrice();
  }


  Future<bool> updateCart(List<CartDetails> cartDetailsList, {String promoCode = ''}) async {
    try{
      loadingUpdateCart = true;
      Cart newCart = Cart(
          finalPrice: 0,
          grandTotal: 0,
          id: 0,
          discount: 0,
          totalPrice: cart.totalPrice,
          totalProducts: cartDetailsList.length,
          printingCost: 100,
          cartDetailsList: cartDetailsList,
          promo: Promo(code: promoCode)
      );

      final response = await orderService.updateCart(newCart);
      print('response--->${response.body}');
      if(response.statusCode==200){
          cart = Cart.fromJson(json.decode(response.body));
      }else{
        print('cart update response error---->${response.body}');
        loadingUpdateCart = false;
        return false;
      }
      loadingUpdateCart = false;
      return true;
    }catch(error){
      print('cart update error---->$error');
      loadingUpdateCart = false;
      return false;
    }

  }

  Future<bool> placeOrder(DeliveryAddress selectedDeliveryAddress) async {
    try{
      loadingOrder = true;
      final response = await orderService.placeOrder(selectedDeliveryAddress);
      if(response.statusCode == 201){
        print('order placed successfully.');
      }else{
        loadingOrder = false;
        print('order place response error --> ${json.decode(response.body)}');
        return false;
      }
      loadingOrder = false;
      return true;

    }catch(error){
      loadingOrder = false;
      print('place order error ---> $error');
      return false;
    }
  }






}