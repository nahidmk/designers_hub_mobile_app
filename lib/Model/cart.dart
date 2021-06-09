import '../Model/cart_details.dart';
import 'package:flutter/material.dart';


class Cart{



    double finalPrice;
    double grandTotal;
    int id;
    double totalPrice;
    int totalProducts;
    double printingCost;
    List<CartDetails> cartDetailsList;


    // CartDetails _cartDetails = CartDetails(designPrice: null, fabricQuantity: null, id: null, pricePerYardFabric: null, totalPrice: null)


  Cart({
     this.finalPrice=0,
     this.grandTotal=0,
     this.id=0,
     this.totalPrice=0,
     this.totalProducts=0,
     this.printingCost=0,
    this.cartDetailsList=const []
  });



  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
      finalPrice: json["finalPrice"] as double,
      grandTotal: json["grandTotal"] as double,
      id: json["id"] as int,
      totalPrice: json["totalPrice"] as double,
      totalProducts: json["totalProducts"] as int,
      printingCost: json["printingCost"] as double,
      cartDetailsList: json["cartDetailsList"]==null?[]:List<CartDetails>.from(json["cartDetailsList"].map((x) => CartDetails.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "totalProducts": totalProducts,
    "totalPrice": totalPrice,
    "grandTotal": grandTotal,
    "printingCost": printingCost,
    "finalPrice": finalPrice,
    "cartDetailsList": cartDetailsList==null?[]:List<dynamic>.from(cartDetailsList.map((x) => x.toJson())),

  };
}
