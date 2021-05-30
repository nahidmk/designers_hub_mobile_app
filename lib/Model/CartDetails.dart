import 'package:flutter/material.dart';


class CartDetails{
  final double designPrice;
  final double fabricquantity;
  final int id;
  final double pricePerYardFabirc;
  final double totalPrice;

  CartDetails({
    required this.designPrice,
    required this.fabricquantity,
    required this.id,
    required this.pricePerYardFabirc,
    required this.totalPrice});

}