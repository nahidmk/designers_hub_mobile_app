

import 'package:designers_hub_modile_app/Model/cart_details.dart';
import 'package:designers_hub_modile_app/Provider/order_provider.dart';
import 'package:designers_hub_modile_app/Provider/design_provider.dart';
import 'package:designers_hub_modile_app/Screen/home_screen.dart';
import 'package:designers_hub_modile_app/widget/cart_details/cart_view.dart';
import 'package:designers_hub_modile_app/widget/common/buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  

   bool fromProductDetails;
  
  CartScreen({

    required this.fromProductDetails
  });

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {



  @override
  Widget build(BuildContext context) {
    OrderProvider cartDesignProvider = Provider.of<OrderProvider>(context);


    return widget.fromProductDetails?Scaffold(
      backgroundColor: CupertinoColors.white,
      appBar: AppBar(
        title: Text(
            'Cart(${cartDesignProvider.cart.cartDetailsList.length})'
        ),
        actions: [
          AppBarButton((){Navigator.push(context, MaterialPageRoute(builder: (_)=>HomeScreen()));},
              "CONTINUE SHOPPING",
              context
          )
      ],),
      body: Container(
        child: CartView(true),
      ),
    ):
     Container(
       // child: Text('hello'),
          child: CartView(false)
    );


    // Scaffold(
    //   backgroundColor: CupertinoColors.white,
    //   body: Container(
    //     child: CartView(false)
    //   ),
    // );

  }
}
