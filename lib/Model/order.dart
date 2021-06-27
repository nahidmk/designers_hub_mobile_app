import 'package:designers_hub_modile_app/Model/cart.dart';
import 'package:designers_hub_modile_app/Model/delivery_address.dart';
import 'package:designers_hub_modile_app/Model/order_status.dart';
import 'package:designers_hub_modile_app/Model/payment_type.dart';
import 'package:designers_hub_modile_app/Model/promo.dart';
import 'package:designers_hub_modile_app/Model/user.dart';

class Order{

  int id;
  String invoiceNumber;
  String createdAt;
  Cart cart;
  PaymentType paymentType;
  DeliveryAddress deliveryAddress;
  OrderStatus orderStatus;
  User user;

  Order({
    required this.id,
    required this.createdAt,
    required this.invoiceNumber,
    required this.cart,
    required this.paymentType,
    required this.orderStatus,
    required this.deliveryAddress,
    required this.user
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
      id: json["id"] as int,
      invoiceNumber: json["invoiceNumber"]==null?" ":json["invoiceNumber"] as String,
      createdAt: json["createdAt"]==null?" ":json["createdAt"] as String,
      cart: json["cart"]==null? Cart(finalPrice: 0, grandTotal: 0, discount: 0, id: 0, totalPrice: 0, totalProducts: 0, printingCost: 0, cartDetailsList: [], promo: Promo(code: ""),):Cart.fromJson(json["cart"]),
      paymentType: json["paymentType"]==null?PaymentType(name: "", value: ""):PaymentType.fromJson(json["paymentType"]),
      orderStatus: json["orderStatus"]==null?OrderStatus(name: "", value: ""):OrderStatus.fromJson(json["orderStatus"]),
      deliveryAddress: json["deliveryAddress"]==null?DeliveryAddress(id: 0, address: "", title: "", phoneNumber: ""):DeliveryAddress.fromJson(json["deliveryAddress"]),
      user: json["user"]==null?User(active: false, address: "", password: '', banned: false, dateOfBirth:"", disabled: false, email: "", fullName: "", gender: '', id: 0, nid: '', nidPictureBack: '', nidPictureFront: '', primaryNumber: '', profilePicture: '', provider: '', providerId: '', secondaryNumber: ''):User.fromJson(json['user']),
  );

  Map<String, dynamic> toJson()=>{
    "id":id,
    "invoiceNumber":invoiceNumber,
    "createdAt":createdAt,
    "cart":cart.cartDetailsList.isEmpty?null:cart.toJson(),
    "paymentTypes":paymentType.name.isEmpty?null:paymentType.toJson(),
    "orderStatus":orderStatus.name.isEmpty?null:orderStatus.toJson(),
    "deliveryAddress":deliveryAddress.title.isEmpty?null:deliveryAddress.toJson(),
    "user":user.primaryNumber.isEmpty?null:deliveryAddress.toJson()
  };



}