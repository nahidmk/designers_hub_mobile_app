
import 'package:designers_hub_modile_app/Model/cart.dart';
import 'package:designers_hub_modile_app/Model/cart_details.dart';
import 'package:flutter/cupertino.dart';

class CartDesignProvider extends ChangeNotifier {

  Cart _cart = Cart(
    id: 0,
    finalPrice: 0,
    cartDetailsList: [],
    grandTotal: 0,
    totalPrice: 0,
    printingCost: 0,
    totalProducts: 0
  );


  Cart get cart => _cart;

  set cart(Cart value) {
    _cart = value;
    notifyListeners();
  }

  void deleteDesign(int id){
    _cart.cartDetailsList.removeWhere((element) => element.design.id==id);
    cart.cartDetailsList = _cart.cartDetailsList;
  }

  void calculateTotalPrice(){
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
  }
}