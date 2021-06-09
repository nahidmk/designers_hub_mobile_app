import 'package:designers_hub_modile_app/Model/cart.dart';

import '../Model/design_image.dart';
import '../Model/fabric.dart';
import '../Model/user.dart';
import 'package:flutter/material.dart';

class Design{

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




   Design(
      {
        this.id =0,
        this.name ='',
        this.price=0,
        this.disabled=false,
        this.descriptions='',
        this.thumbnail='',
        this.favCount=0,
        this.designImages = const [],
        this.fabrics = const [],
        this.user =
      })
  ;

factory Design.fromJson(Map<String, dynamic> json) => Design(
    id: json["id"] as int,
    name: json["name"]==null?'':json["name"] as String,
    thumbnail: json["thumbnail"]==null? '':json["thumbnail"] as String,
    favCount: json["favCount"] as int,
    disabled: json["disabled"] as bool,
    descriptions: json["descriptions"] == null ? '' : json["descriptions"] as String,
    price: json["price"] as double,
    designImages: List<DesignImage>.from(json["designImages"].map((x) => DesignImage.fromJson(x))),
    fabrics: List<Fabric>.from(json["fabrics"].map((x) => Fabric.fromJson(x))),
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