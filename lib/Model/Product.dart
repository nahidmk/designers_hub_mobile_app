import '../Model/DesignImage.dart';
import '../Model/Fabric.dart';
import '../Model/User.dart';
import 'package:flutter/material.dart';

class Product{

  final int id;
  final String name;
  final double price;
  final bool disabled;
  final String descriptions;
  final String thumbnail;
  final int favCount;
  final List<Fabric> fabrics;
  final List<DesignImage> designImages;
  final User user;


  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.disabled,
    required this.descriptions,
    required this.thumbnail,
    required this.favCount,
    required this.designImages,
    required this.fabrics,
    required this.user});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    thumbnail: json["thumbnail"],
    favCount: json["favCount"],
    disabled: json["disabled"],
    descriptions: json["descriptions"] == null ? null : json["descriptions"],
    price: json["price"] == null ? null : json["price"],
    designImages: json["designImages"] == null ? null : List<DesignImage>.from(json["designImages"].map((x) => DesignImage.fromJson(x))),
    fabrics: json["fabrics"] == null ? null : List<Product>.from(json["fabrics"].map((x) => Product.fromJson(x))),
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "thumbnail": thumbnail,
    "favCount": favCount,
    "disabled": disabled,
    "descriptions": descriptions == null ? null : descriptions,
    "price": price == null ? null : price,
    "designImages": designImages == null ? null : List<dynamic>.from(designImages.map((x) => x.toJson())),
    "fabrics": fabrics == null ? null : List<dynamic>.from(fabrics.map((x) => x.toJson())),
    "user": user.toJson(),
  };

}