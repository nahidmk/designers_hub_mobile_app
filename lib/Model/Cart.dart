import '../Model/CartDetails.dart';
import 'package:flutter/material.dart';


class Cart{

  final double finalPrice;
  final double grandTotal;
  final int id;
  final double totalPrice;
  final int totalProduct;
  final double printingCost;
  final List<CartDetails> cartDetails;

  Cart({required this.finalPrice, required this.grandTotal, required this.id, required this.totalPrice,
      required this.totalProduct, required this.printingCost, required this.cartDetails});
}