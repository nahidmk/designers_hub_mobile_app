import 'package:designers_hub_modile_app/Model/design.dart';
import 'package:designers_hub_modile_app/Model/fabric.dart';
import 'package:flutter/material.dart';


class CartDetails{



   double designPrice;
   int id;
   double totalPrice;
   int quantity;
   Design design;
   double fabricPrice;
   Fabric fabric;
   String note;


CartDetails({
    required this.designPrice,
    required this.id,
    required this.totalPrice,
    required this.quantity,
    required this.design,
    required this.fabric,
    required this.note,
  required this.fabricPrice,
});


  factory CartDetails.fromJson(Map<String, dynamic> json) => CartDetails(
    id: json["id"] as int,
    designPrice: json["designPrice"] as double,
    totalPrice: json["totalPrice"] as double,
    quantity: json["quantity"] as int,
    note: json["note"]==null?"":json["note"] as String,
    fabricPrice: json["fabricPrice"] as double,
    design: Design.fromJson(json["design"]),
    fabric: Fabric.fromJson(json["fabric"]),
  );


  Map<String, dynamic> toJson() => {
    "id": id,
    "designPrice": designPrice,
    "totalPrice": totalPrice,
    "quantity":quantity,
    "note":note,
    "fabricPrice":fabricPrice,
    "design":design.toJson(),
    "fabric":fabric.toJson(),
  };

}