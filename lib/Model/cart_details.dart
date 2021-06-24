import 'package:designers_hub_modile_app/Model/design.dart';
import 'package:designers_hub_modile_app/Model/fabric.dart';
import 'package:flutter/material.dart';


class CartDetails{



   double designPrice;
   int id;
   double totalPrice;
   double quantity;
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
    designPrice: json["designPrice"]==null? 0.0 :json["designPrice"] as double,
    totalPrice: json["totalPrice"]==null? 0.0 :json["totalPrice"] as double,
    quantity: json["quantity"]==null? 0.0 :json["quantity"] as double,
    note: json["note"]==null?"":json["note"] as String,
    fabricPrice: json["fabricPrice"]==null? 0.0 : json["fabricPrice"] as double,
    design: Design.fromJson(json["design"]),
    fabric:json["fabric"]==null? Fabric(available: false, baseColor: "", descriptions: "", disabled: false, favCount: 0, id: 0, name: "", price: 0, slug: '', fabricMixings: [], thumbnail: ""): Fabric.fromJson(json["fabric"]),
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