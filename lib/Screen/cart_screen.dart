

import 'package:designers_hub_modile_app/Model/cart_details.dart';
import 'package:designers_hub_modile_app/Screen/home_screen.dart';
import 'package:designers_hub_modile_app/widget/cart_details/cart_view.dart';
import 'package:designers_hub_modile_app/widget/common/buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  
   List<CartDetails> cartDetailList;
   bool fromProductDetails;
  
  CartScreen({
    this.cartDetailList=const [],
    required this.fromProductDetails
  });

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return widget.fromProductDetails?Scaffold(
      backgroundColor: CupertinoColors.white,
      appBar: AppBar(
        title: Text(
            'Cart(${widget.cartDetailList.length})'
        ),
        actions: [
          AppBarButton((){Navigator.push(context, MaterialPageRoute(builder: (_)=>HomeScreen()));},
              "CONTINUE SHOPPING",
              context
          )
      ],),
      body: Container(
        child: CartView(cartDetailsList: widget.cartDetailList,),
      ),
    ):Scaffold(
      backgroundColor: CupertinoColors.white,
      body: Container(
        child: CartView(cartDetailsList: widget.cartDetailList,)
      ),
    );

  }
}
