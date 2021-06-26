import 'package:designers_hub_modile_app/Model/cart.dart';
import 'package:designers_hub_modile_app/Model/cart_details.dart';
import 'package:designers_hub_modile_app/Provider/order_provider.dart';
import 'package:designers_hub_modile_app/Screen/checkout_screen.dart';
import 'package:designers_hub_modile_app/Screen/delvery_address_screen.dart';
import 'package:designers_hub_modile_app/Screen/home_screen.dart';
import 'package:designers_hub_modile_app/helper/currency.dart';
import 'package:designers_hub_modile_app/widget/cart_details/single_product_cart.dart';
import 'package:designers_hub_modile_app/widget/common/buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartView extends StatefulWidget {

 bool fromProductDetails;

 CartView(this.fromProductDetails);

  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {



  @override
  Widget build(BuildContext context) {
    OrderProvider cartDesignProvider = Provider.of<OrderProvider>(context);
    Cart _cart = cartDesignProvider.cart;

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
                ...cartDesignProvider.cart.cartDetailsList.map((e)=>SingleProductCart(cartDetails: e)),

              ],
          ),
            ),



        ]
        ),
      ),

        widget.fromProductDetails?
        Positioned(
          bottom: 0,
          child: Container(
              padding: EdgeInsets.only(top: 5,left: 10,right: 10),
              decoration: BoxDecoration(
                color: Colors.white,),
              width: MediaQuery.of(context).size.width,
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width,
                      child:Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Estimated Total",style: Theme.of(context).textTheme.headline4,),
                                Text("$CURRENCY ${_cart.totalPrice}",style: Theme.of(context).textTheme.headline4,)
                              ],
                            ),
                            SizedBox(height: 5,),
                            Text("Note: All price in the cart and during checkout are show including tax",style: Theme.of(context).textTheme.bodyText1 ),
                          ]
                      )
                  ),

                  secondaryButton((){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>CheckoutScreen(cartDesignProvider.cart.cartDetailsList)));
                  }, "Check Out", context)
                ],
              )
          ),
        )
        :Positioned(
          bottom: 50,
          child: Container(
              padding: EdgeInsets.only(top: 5,left: 10,right: 10),
              decoration: BoxDecoration(
                color: Colors.white,),
              width: MediaQuery.of(context).size.width,
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                   Container(
                        width: MediaQuery.of(context).size.width,
                        child:Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Estimated Total",style: Theme.of(context).textTheme.headline4,),
                                  Text("$CURRENCY ${_cart.totalPrice}",style: Theme.of(context).textTheme.headline4,)
                                ],
                              ),
                              SizedBox(height: 5,),
                              Text("Note: All price in the cart and during checkout are show including tax",style: Theme.of(context).textTheme.bodyText1 ),
                            ]
                        )
                    ),

                  secondaryButton((){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>CheckoutScreen(cartDesignProvider.cart.cartDetailsList)));
                  }, "Check Out", context)
                ],
              )
          ),
        ),
      ]);

  }
}
