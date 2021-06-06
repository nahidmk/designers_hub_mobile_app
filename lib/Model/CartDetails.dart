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
    id: json["id"],
    fabricQuantity: json["fabricQuantity"],
    pricePerYardFabric: json["pricePerYardFabric"],
    designPrice: json["designPrice"],
    totalPrice: json["totalPrice"],
  );


  Map<String, dynamic> toJson() => {
    "id": id,
    "fabricQuantity": fabricQuantity,
    "pricePerYardFabric": pricePerYardFabric,
    "designPrice": designPrice,
    "totalPrice": totalPrice,
  };

}