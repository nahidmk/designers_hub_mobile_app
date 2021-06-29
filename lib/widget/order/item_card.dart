import 'package:designers_hub_modile_app/Model/cart_details.dart';
import 'package:designers_hub_modile_app/helper/constants.dart';
import 'package:designers_hub_modile_app/helper/currency.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {

  CartDetails cartDetails;

  ItemCard(this.cartDetails);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Card(
        child: Row(

          children: [
            Container(
              padding: EdgeInsets.all(5),
              height: 70,
              width: 70,
              child: Image.network("$IMAGE_URL${cartDetails.design.thumbnail}",fit: BoxFit.fill,),
            ),
            Container(
              width: MediaQuery.of(context).size.width-100,
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(cartDetails.design.name,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
                  Divider(),
                  CustomRow(cartDetails.design.designType.requiredFabric?"Fabric ${cartDetails.fabric.name}":'', "$CURRENCY${cartDetails.totalPrice.toString()}"),
                  CustomRow('Quantity',cartDetails.quantity.toInt().toString() ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget CustomRow(String title, String price){

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(title),
      Text(price,),
    ],
  );
}
