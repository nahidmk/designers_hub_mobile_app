import 'package:designers_hub_modile_app/Model/promo.dart';

import '../Model/cart_details.dart';
import 'package:flutter/material.dart';


class Cart{



     double finalPrice;
     double grandTotal;
     int id;
     double totalPrice;
     int totalProducts;
     double printingCost;
     double discount;
     List<CartDetails> cartDetailsList;
     Promo promo;

  Cart({
     required this.finalPrice,
     required this.grandTotal,
    required this.discount,
     required this.id,
     required this.totalPrice,
     required this.totalProducts,
     required this.printingCost,
      required this.cartDetailsList,
    required this.promo,
  });



  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
      finalPrice: json["finalPrice"] == null ? 0.0 : json["finalPrice"] as double,
      grandTotal: json["grandTotal"] == null ? 0.0 : json["grandTotal"] as double,
      id: json["id"] as int,
      discount: json["discount"] == null ? 0.0 : json["discount"] as double,
      totalPrice: json["totalPrice"] == null ? 0.0 : json["totalPrice"] as double,
      totalProducts: json["totalProducts"] == null ? 0 : json["totalProducts"] as int,
      printingCost: json["printingCost"] == null ? 0.0 : json["printingCost"] as double,
      promo: json["promo"]==null? Promo(code: "",):Promo.fromJson(json["promo"]),
      cartDetailsList:json["cartDetailsList"]==null?[]:List<CartDetails>.from(json["cartDetailsList"].map((x) => CartDetails.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "totalProducts": totalProducts,
    "totalPrice": totalPrice,
    "grandTotal": grandTotal,
    "printingCost": printingCost,
    "finalPrice": finalPrice,
    "discount" : discount,
    "promo" : promo.code.isEmpty ? null : promo.toJson(),
    "cartDetailsList": cartDetailsList==null?[]:List<dynamic>.from(cartDetailsList.map((x) => x.toJson())),

  };
}
