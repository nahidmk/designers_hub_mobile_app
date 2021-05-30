import '../Model/DesignImage.dart';
import '../Model/Fabrics.dart';
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
  final List<Fabrics> fabrics;
  final List<DesignImage> designImage;
  final User user;


  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.disabled,
    required this.descriptions,
    required this.thumbnail,
    required this.favCount,
    required this.designImage,
    required this.fabrics,
    required this.user});

}