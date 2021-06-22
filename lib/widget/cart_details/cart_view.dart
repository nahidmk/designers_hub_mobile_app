import 'package:designers_hub_modile_app/Model/cart_details.dart';
import 'package:designers_hub_modile_app/Screen/delvery_address_screen.dart';
import 'package:designers_hub_modile_app/Screen/home_screen.dart';
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


        child: Column(

          children:[
            Container(
              // decoration: BoxDecoration(border: Border.all(color: Colors.red,width: 2.0)),

            height: MediaQuery.of(context).size.height-210,
              child: ListView(

              children: [
                ...widget.cartDetailsList.map((e)=>SingleProductCart(cartDetails: e)),

                SizedBox(height: 231,)
              ],
          ),
            ),
            Card(
              elevation: 5,
              child: Container(
                padding: EdgeInsets.all(5),

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
                      ]
                  )
              ),
            ),


        ]
        ),
      ),

        Positioned(
          bottom: 0,
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              decoration: BoxDecoration(
                color: Colors.white,),
              width: MediaQuery.of(context).size.width,
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  secondaryButton((){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>DeliveryAddressScreen()));
                  }, "Check Out", context)
                ],
              )
          ),
        ),
      ]);

  }
}
