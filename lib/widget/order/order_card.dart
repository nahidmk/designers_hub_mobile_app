import 'package:designers_hub_modile_app/Model/cart.dart';
import 'package:designers_hub_modile_app/Model/delivery_address.dart';
import 'package:designers_hub_modile_app/Model/order.dart';
import 'package:designers_hub_modile_app/Model/order_status.dart';
import 'package:designers_hub_modile_app/Model/payment_type.dart';
import 'package:designers_hub_modile_app/Model/promo.dart';
import 'package:designers_hub_modile_app/Model/user.dart';
import 'package:designers_hub_modile_app/Screen/order_details_screen.dart';
import 'package:designers_hub_modile_app/helper/currency.dart';
import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {

  Order order = Order(
      id: 0,
      invoiceNumber: '',
      createdAt: '',
      cart: Cart(finalPrice: 0, grandTotal: 0, discount: 0, id: 0, totalPrice: 0, totalProducts: 0, printingCost: 0, cartDetailsList: [], promo: Promo(code: '')),
      paymentType: PaymentType(name: '', value: ''),
      orderStatus: OrderStatus(name: '', value: ''),
      deliveryAddress: DeliveryAddress(id: 0, address: '', title: '', phoneNumber: ''),
      user: User(active: false, address: "", banned: false, password: '', dateOfBirth:"", disabled: false, email: "", fullName: "", gender: '', id: 0, nid: '', nidPictureBack: '', nidPictureFront: '', primaryNumber: '', profilePicture: '', provider: '', providerId: '', secondaryNumber: '')
  );

  OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        print('order id --->${order.id}');
        Navigator.push(context, MaterialPageRoute(builder: (_)=>OrderDetailsScreen(id: order.id,)));
      },
      child: Card(
        child:Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              CustomRow("ID: ${order.id}", "$CURRENCY${order.cart.grandTotal}"),
              Divider(),
              CustomRow("Receiver : ", "${order.user.fullName}"),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(order.createdAt),
                  Icon(Icons.arrow_forward_sharp),
                ],
              )
            ],
          ),
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
