
import 'package:designers_hub_modile_app/Model/cart_details.dart';
import 'package:designers_hub_modile_app/Screen/cart_screen.dart';
import 'package:designers_hub_modile_app/helper/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


AppBar buildCustomAppbar(String title, BuildContext context,List<CartDetails>cartDetailsList){
  return AppBar(
    title: Text(
      title,
    ),
    actions: [
      IconButton(onPressed: (){
           Navigator.push(context,MaterialPageRoute(builder: (_)=> CartScreen(fromProductDetails: true,cartDetailList: cartDetailsList,)));
      }, icon: Icon(CupertinoIcons.shopping_cart))
    ],
  );
}
