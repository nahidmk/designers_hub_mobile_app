
import 'package:designers_hub_modile_app/Model/cart_details.dart';
import 'package:designers_hub_modile_app/Provider/order_provider.dart';
import 'package:designers_hub_modile_app/Screen/cart_screen.dart';
import 'package:designers_hub_modile_app/helper/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


AppBar buildCustomAppbar(String title, BuildContext context){

  OrderProvider orderProvider = Provider.of<OrderProvider>(context,listen: false);

  return AppBar(
    title: Text(
      title,
    ),
    actions: [
      Stack(
        children: [
          Container(
            margin: EdgeInsets.only(right: 13),
            child: IconButton(onPressed: (){
              Navigator.push(context,MaterialPageRoute(builder: (_)=> CartScreen(fromProductDetails: true,)));
            }, icon: Icon(CupertinoIcons.shopping_cart))
            ,
          ),
          orderProvider.cart.cartDetailsList.length>=1?
          Positioned(
              top: 4,
              right: 8,
              child: Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                child: Center( child: Text("${orderProvider.cart.cartDetailsList.length}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
              )
          ):SizedBox(),
        ],
      )

    ],
  );
}
