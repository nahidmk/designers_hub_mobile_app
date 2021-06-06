import '../Model/CartDetails.dart';
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
      finalPrice: json["finalPrice"],
      grandTotal: json["grandTotal"],
      id: json["id"],
      totalPrice: json["totalPrice"],
      totalProducts: json["totalProducts"],
      printingCost: json["printingCost"],
      cartDetailsList: List<CartDetails>.from(json["cartDetailsList"].map((x) => CartDetails.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "totalProducts": totalProducts,
    "totalPrice": totalPrice,
    "grandTotal": grandTotal,
    "printingCost": printingCost,
    "finalPrice": finalPrice,
    "cartDetailsList": List<dynamic>.from(cartDetailsList.map((x) => x.toJson())),

  };
}
