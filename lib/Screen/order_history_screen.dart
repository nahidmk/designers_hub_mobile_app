import 'package:designers_hub_modile_app/widget/order/order_list.dart';
import 'package:flutter/material.dart';


class OrderHistoryScreen extends StatefulWidget {


  @override
  _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Order history'),),
      body: OrderList(),
    );
  }
}
