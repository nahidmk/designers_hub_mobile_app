import 'package:designers_hub_modile_app/Model/cart.dart';

import '../Model/design_image.dart';
import '../Model/fabric.dart';
import '../Model/user.dart';
import 'package:flutter/material.dart';

class Design{

   int id;
   String name;
   double price;
   bool disabled;
   String descriptions;
   String thumbnail;
   int favCount;
   List<Fabric> fabrics;
   List<DesignImage> designImages;
   User user;


  Design({
      required this.id,
      required this.name,
      required this.price,
      required this.disabled,
      required this.descriptions,
      required this.thumbnail,
      required this.favCount,
      required this.fabrics,
      required this.designImages,
      required this.user});

  factory Design.fromJson(Map<String, dynamic> json) => Design(
    id: json["id"] as int,
    name: json["name"]==null?'':json["name"] as String,
    thumbnail: json["thumbnail"]==null? '':json["thumbnail"] as String,
    favCount: json["favCount"] as int,
    disabled: json["disabled"] as bool,
    descriptions: json["descriptions"] == null ? '' : json["descriptions"] as String,
    price: json["price"] as double,
    designImages: json["designImages"]==null?[]:List<DesignImage>.from(json["designImages"].map((x) => DesignImage.fromJson(x))),
    fabrics: json["fabrics"]==null?[]: List<Fabric>.from(json["fabrics"].map((x) => Fabric.fromJson(x))),
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "thumbnail": thumbnail,
    "favCount": favCount,
    "disabled": disabled,
    "descriptions": descriptions,
    "price": price,
    "designImages": List<dynamic>.from(designImages.map((x) => x.toJson())),
    "fabrics": List<dynamic>.from(fabrics.map((x) => x.toJson())),
    "user": user.toJson(),
  };

}