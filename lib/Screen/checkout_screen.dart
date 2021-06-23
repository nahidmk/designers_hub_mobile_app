
import 'package:designers_hub_modile_app/Model/delivery_address.dart';
import 'package:designers_hub_modile_app/Provider/delivery_address_provider.dart';
import 'package:designers_hub_modile_app/Provider/design_provider.dart';
import 'package:designers_hub_modile_app/Screen/delvery_address_screen.dart';
import 'package:designers_hub_modile_app/widget/common/buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {


  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {




  @override
  Widget build(BuildContext context) {

    DeliveryAddressProvider deliveryAddressProvider = Provider.of<DeliveryAddressProvider>(context);
    DeliveryAddress selectDeliveryAddress = deliveryAddressProvider.selectedDeliveryAddress;

    return Scaffold(
      appBar: AppBar(title: Text("Check out"),),
      body: SingleChildScrollView(
        child: Column(

          children: [
            selectDeliveryAddress.title.isEmpty?
            secondaryButton((){
              Navigator.push(context, MaterialPageRoute(builder: (_)=>DeliveryAddressScreen()));
            }, "Choose Address", context)
                : Card(
              margin: EdgeInsets.all(10),
                child: Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(child: Text('Delivery Address',style: Theme.of(context).textTheme.headline1,)),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(selectDeliveryAddress.title,style: Theme.of(context).textTheme.headline4,),
                              Text(selectDeliveryAddress.address,style: Theme.of(context).textTheme.headline6),
                              Text(selectDeliveryAddress.phoneNumber,style: Theme.of(context).textTheme.headline6),
                            ],
                          ),
                          TextButton(onPressed:()=> Navigator.push(context, MaterialPageRoute(builder: (_)=>DeliveryAddressScreen()))
                              , child: Text('Change',style: TextStyle(fontWeight: FontWeight.bold),))
                        ],

                      ),
                    ],
                  )
                )
            ),

            //payment info
            Card(
              margin: EdgeInsets.only(bottom: 10,left: 10,right: 10),
              child: Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(child: Text('Payment Information',style: Theme.of(context).textTheme.headline1,),),
                    Divider(),
                    PayMentInfo("Total Price", "123"),
                    SizedBox(height: 10,),
                    PayMentInfo("Delivery Charge", "123"),
                    SizedBox(height: 10,),
                    PayMentInfo("Final price", "123"),
                  ],
                ),
              ),
            ),



           Container(
             width: MediaQuery.of(context).size.width-50,
             child:  secondaryButton((){}, "Place Order", context),
           )

          ],

        ),
      ),
    );
  }
}

Widget PayMentInfo(String title, String price){

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(title),
      Text(price,),
    ],
  );
}