import '../Model/cart_details.dart';
import 'package:flutter/material.dart';


class Cart{



  final double finalPrice;
  final double grandTotal;
  final int id;
  final double totalPrice;
  final int totalProducts;
  final double printingCost;
  final List<CartDetails> cartDetailsList;





  Cart({required this.finalPrice, required this.grandTotal, required this.id, required this.totalPrice,
      required this.totalProducts, required this.printingCost, required this.cartDetailsList});

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
      finalPrice: json["finalPrice"] as double,
      grandTotal: json["grandTotal"] as double,
      id: json["id"] as int,
      totalPrice: json["totalPrice"] as double,
      totalProducts: json["totalProducts"] as int,
      printingCost: json["printingCost"] as double,
      cartDetailsList: json["cartDetailsList"]==null?[]:List<CartDetails>.from(json["cartDetailsList"].map((x) => CartDetails.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "totalProducts": totalProducts,
    "totalPrice": totalPrice,
    "grandTotal": grandTotal,
    "printingCost": printingCost,
    "finalPrice": finalPrice,
    "cartDetailsList": cartDetailsList==null?[]:List<dynamic>.from(cartDetailsList.map((x) => x.toJson())),

  };
}
