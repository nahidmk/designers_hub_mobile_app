import 'package:designers_hub_modile_app/Model/cart_details.dart';
import 'package:designers_hub_modile_app/helper/currency.dart';
import 'package:designers_hub_modile_app/widget/cart_details/single_product_cart.dart';
import 'package:designers_hub_modile_app/widget/common/buttons.dart';
import 'package:flutter/material.dart';

class CartView extends StatefulWidget {

  final List<CartDetails> cartDetailsList;

  CartView({required this.cartDetailsList});

  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(

        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: Colors.blueGrey
                ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Cart (${widget.cartDetailsList.length})",style: Theme.of(context).textTheme.headline4,),
                  secondaryButton((){}, "CONTINUE SHOPPING", context)
                ],
              ),
            ),
            SizedBox(height: 10,),

            ...widget.cartDetailsList.map((e)=>SingleProductCart(cartDetails: e)),


          ],
        ),
      ),
        Positioned(
          bottom: 0,
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,),
              width: MediaQuery.of(context).size.width,
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Estimated Total",style: Theme.of(context).textTheme.headline4,),
                      Text("$CURRENCY 17.50",style: Theme.of(context).textTheme.headline4,)
                    ],
                  ),
                  SizedBox(height: 5,),
                  Text("Note: All price in the cart and during checkout are show including tax",style: Theme.of(context).textTheme.bodyText1 ),
                  SizedBox(height: 5,),
                  secondaryButton((){}, "Check Out", context)
                ],
              )
          ),
        ),
      ]);

  }
}
