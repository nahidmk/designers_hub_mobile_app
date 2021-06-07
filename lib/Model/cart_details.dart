import 'package:flutter/material.dart';


class CartDetails{



  final double designPrice;
  final double fabricQuantity;
  final int id;
  final double pricePerYardFabric;
  final double totalPrice;



  CartDetails({
    required this.designPrice,
    required this.fabricQuantity,
    required this.id,
    required this.pricePerYardFabric,
    required this.totalPrice});


  factory CartDetails.fromJson(Map<String, dynamic> json) => CartDetails(
    id: json["id"] as int,
    fabricQuantity: json["fabricQuantity"] as double,
    pricePerYardFabric: json["pricePerYardFabric"] as double,
    designPrice: json["designPrice"] as double,
    totalPrice: json["totalPrice"] as double,
  );


  Map<String, dynamic> toJson() => {
    "id": id,
    "fabricQuantity": fabricQuantity,
    "pricePerYardFabric": pricePerYardFabric,
    "designPrice": designPrice,
    "totalPrice": totalPrice,
  };

}