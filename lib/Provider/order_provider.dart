import 'dart:convert';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:designers_hub_modile_app/Model/cart.dart';
import 'package:designers_hub_modile_app/Model/cart_details.dart';
import 'package:designers_hub_modile_app/Model/delivery_address.dart';
import 'package:designers_hub_modile_app/Model/order.dart';
import 'package:designers_hub_modile_app/Model/order_status.dart';
import 'package:designers_hub_modile_app/Model/payment_type.dart';
import 'package:designers_hub_modile_app/Model/promo.dart';
import 'package:designers_hub_modile_app/Model/user.dart';
import 'package:designers_hub_modile_app/Service/oder_service.dart';
import 'package:designers_hub_modile_app/helper/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderProvider extends ChangeNotifier {
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

  Order _order = Order(
      id: 0,
      invoiceNumber: '',
      createdAt: '',
      cart: Cart(
          finalPrice: 0,
          grandTotal: 0,
          discount: 0,
          id: 0,
          totalPrice: 0,
          totalProducts: 0,
          printingCost: 0,
          cartDetailsList: [],
          promo: Promo(code: '')),
      paymentType: PaymentType(name: '', value: ''),
      orderStatus: OrderStatus(name: '', value: ''),
      deliveryAddress:
          DeliveryAddress(id: 0, address: '', title: '', phoneNumber: ''),
      user: User(
          active: false,
          address: "",
          password: '',
          banned: false,
          dateOfBirth: "",
          disabled: false,
          email: "",
          fullName: "",
          gender: '',
          id: 0,
          nid: '',
          nidPictureBack: '',
          nidPictureFront: '',
          primaryNumber: '',
          profilePicture: '',
          provider: '',
          providerId: '',
          secondaryNumber: ''));

  Order get order => _order;

  set order(Order value) {
    _order = value;
    notifyListeners();
  }

  OrderProvider() {
    _loadCart();
  }

  bool _loadingOrders = true;
  String _orderErrorMsg = '';
  int _totalElements = 0;
  List<Order> _orderList = [];
  String _ordersErrorMsg = '';

  int _currentPage = 0;
  bool _loadingMore = false;

  int get currentPage => _currentPage;

  set currentPage(int value) {
    _currentPage = value;
    notifyListeners();
  }

  bool get loadingMore => _loadingMore;

  set loadingMore(bool value) {
    _loadingMore = value;
    notifyListeners();
  }

  String get ordersErrorMsg => _ordersErrorMsg;

  set ordersErrorMsg(String value) {
    _ordersErrorMsg = value;
    notifyListeners();
  }

  List<Order> get orderList => _orderList;

  set orderList(List<Order> value) {
    _orderList = value;
    notifyListeners();
  }

  bool get loadingOrders => _loadingOrders;

  set loadingOrders(bool value) {
    _loadingOrders = value;
    notifyListeners();
  }

  void _loadCart() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? cartString = pref.getString('cart');
    if (cartString != null) {
      cart = Cart.fromJson(json.decode(cartString));
    }
  }

  bool _loadingUpdateCart = false;

  bool get loadingUpdateCart => _loadingUpdateCart;

  set loadingUpdateCart(bool value) {
    _loadingUpdateCart = value;
    notifyListeners();
  }

  String get orderErrorMsg => _orderErrorMsg;

  set orderErrorMsg(String value) {
    _orderErrorMsg = value;
    notifyListeners();
  }

  int get totalElements => _totalElements;

  set totalElements(int value) {
    _totalElements = value;
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

  Future<void> clearCard() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove("cart");
    cart = Cart(
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
    calculateTotalPrice();
  }

  void deleteDesign(int id) {
    _cart.cartDetailsList.removeWhere((element) => element.design.id == id);
    calculateTotalPrice();
  }

  void calculateTotalPrice() async {
    double totalPrice = 0;

    for (int i = 0; i < cart.cartDetailsList.length; i++) {
      CartDetails cartDetails = cart.cartDetailsList[i];
      if (cartDetails.design.designType.requiredFabric) {
        totalPrice += cart.cartDetailsList[i].design.price +
            (cartDetails.fabric.price * cartDetails.quantity);
      } else {
        totalPrice += cartDetails.design.price * cartDetails.quantity;
      }
    }
    _cart.totalPrice = totalPrice;
    cart = _cart;
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('cart', json.encode(cart.toJson()));
  }

  void addToCart(CartDetails cartDetails, double quantity) {
    final exist = _cart.cartDetailsList
        .where((element) => element.design.id == cartDetails.design.id);

    if (exist.isNotEmpty) {
      _cart.cartDetailsList = _cart.cartDetailsList.map((e) {
        if (e.design.id == cartDetails.design.id) {
          e.quantity = quantity;
        }
        return e;
      }).toList();
    } else {
      cartDetails.quantity = quantity;
      _cart.cartDetailsList.add(cartDetails);
    }
    calculateTotalPrice();
  }

  Future<bool> updateCart(List<CartDetails> cartDetailsList,
      {String promoCode = ''}) async {
    try {
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
          promo: Promo(code: promoCode));

      final response = await orderService.updateCart(newCart);
      // print('response--->${response.body}');
      if (response.statusCode == 200) {
        loadingUpdateCart = false;
        cart = Cart.fromJson(json.decode(response.body));
      } else {
        // print('cart update response error---->${response.body}');
        BotToast.showText(
            text: '${json.decode(response.body)["message"]}');
        loadingUpdateCart = false;
        return false;
      }
      loadingUpdateCart = false;
      return true;
    } catch (error) {
      // print('cart update error---->$error');
      BotToast.showText(
          text: "Some thing went wrong");
      loadingUpdateCart = false;
      return false;
    }
  }

  Future<Order> placeOrder(DeliveryAddress selectedDeliveryAddress, BuildContext context) async {
    try {
      loadingOrder = true;
      final response = await orderService.placeOrder(selectedDeliveryAddress);
      if (response.statusCode == 201) {
        print('successful order - >${response.body}');

        order = Order.fromJson(json.decode(response.body));
        clearCard();
        showSuccessMessage("Order hase been placed successfully", context);
        loadingOrder = false;
      } else {
        loadingOrder = false;
        BotToast.showText(text: json.decode(response.body)["message"]);
        print('order place response error --> ${json.decode(response.body)}');
        return order;
      }
      loadingOrder = false;
      return order;
    } catch (error) {
      loadingOrder = false;
      showApiErrorMessage(error, context);
      print('place order error ---> $error');
      return order;
    }
  }

  Future<List<Order>> getAllOrder(
      {int page = 0, int size = 10, bool loadMore = false}) async {
    try {
      !loadMore ? loadingOrders = true : loadingMore = true;
      page = loadingMore ? currentPage : page;
      setCurrentPage(page, loadingMore);

      ordersErrorMsg = '';
      Response response =
          await orderService.getAllOrder(page: page, size: size);

      print("response --->${json.decode(response.body)}");

      totalElements = json.decode(response.body)['totalElements'];

      orderList = loadMore
          ? [
              ..._orderList,
              ...(json.decode(response.body)['content'] as List)
                  .map((value) => Order.fromJson(value))
                  .toList()
            ]
          : (json.decode(response.body)['content'] as List)
              .map((value) => Order.fromJson(value))
              .toList();

      !loadMore ? loadingOrders = false : loadingMore = false;
      return _orderList;
    } catch (error) {
      !loadMore ? loadingOrders = false : loadingMore = false;
      ordersErrorMsg = getErrorMsg(error);
    }
    return [];
  }

  Future getOrderByOrderId(int orderId) async {
    loadingOrder = true;
    orderErrorMsg = '';
    try {
      Response response = await orderService.getOrderByOrderId(orderId);

      if (response.statusCode == 200) {
        order = Order.fromJson(json.decode(response.body));
      } else {
        orderErrorMsg = 'Can not load order. Try again later';

        print(json.decode(response.body));
      }
      loadingOrder = false;
    } catch (error) {
      print(error.toString());
      BotToast.showText(text: error.toString());
      orderErrorMsg = getErrorMsg(error);
      loadingOrder = false;
    }
  }

  String getErrorMsg(error) {
    if (error is SocketException) {
      return 'Please check your internet connection !';
    } else {
      return 'Something went wrong. Please try again later !';
    }
  }

  setCurrentPage(int page, bool __loadingMore) {
    if (!__loadingMore && currentPage > 0) {
      currentPage = page;
    }
    currentPage = currentPage + 1;
  }
}
