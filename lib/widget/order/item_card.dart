import 'package:designers_hub_modile_app/Model/cart_details.dart';
import 'package:designers_hub_modile_app/helper/constants.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {

  CartDetails cartDetails;

  ItemCard(this.cartDetails);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Row(
          children: [
            Container(
              height: 70,
              width: 70,
              child: Image.network("$IMAGE_URL${cartDetails.design.thumbnail}",fit: BoxFit.fill,),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(cartDetails.design.name,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
                  Divider(),
                  CustomRow(cartDetails.design.designType.requiredFabric?"Fabric ${cartDetails.fabric.name}":'', cartDetails.totalPrice.toString()),
                  CustomRow('Quantity',cartDetails.quantity.toString() ),
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
