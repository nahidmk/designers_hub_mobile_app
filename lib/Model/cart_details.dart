import 'package:flutter/material.dart';


class CartDetails{



   double designPrice;
   double fabricQuantity;
   int id;
   double pricePerYardFabric;
   double totalPrice;

   CartDetails({this.designPrice=0, this.fabricQuantity=0, this.id=0,
      this.pricePerYardFabric=0, this.totalPrice=0});

// CartDetails({
  //   required this.designPrice
  //  {this.fabricQuantity=0},
  //   required this.id,
  //   required this.pricePerYardFabric,
  //   required this.totalPrice});


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