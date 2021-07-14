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
      margin: EdgeInsets.only(top: 7,left: 7,right: 7),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(5),
            bottomRight: Radius.circular(5),
            bottomLeft: Radius.circular(5),
            topLeft: Radius.circular(5)
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
        child: Row(

          children: [
            Container(
              padding: EdgeInsets.all(5),
              height: 70,
              width: 70,
              child: FadeInImage(
                placeholder: AssetImage('assets/images/placeholder.jpg'),
                image: NetworkImage("$IMAGE_URL${cartDetails.design.thumbnail}"),
              ),
              // child: Image.network("$IMAGE_URL${cartDetails.design.thumbnail}",fit: BoxFit.fill,),
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
                  CustomRow(cartDetails.design.designType.requiredFabric?"Fabric : ${cartDetails.fabric.name}":'', "$CURRENCY${cartDetails.totalPrice.toString()}"),
                  CustomRow('Quantity',cartDetails.quantity.toInt().toString() ),
                ],
              ),
            )
          ],
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
