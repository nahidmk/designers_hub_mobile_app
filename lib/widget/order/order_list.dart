import 'package:designers_hub_modile_app/Model/order.dart';
import 'package:designers_hub_modile_app/Provider/order_provider.dart';
import 'package:designers_hub_modile_app/widget/error/show_error.dart';
import 'package:designers_hub_modile_app/widget/order/order_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderList extends StatefulWidget {
  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  List<Order> _orderList = [];

 

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      _getAllOrders(false);
    });
  }

 

  _getAllOrders(bool loadMore) async {
    print('constractor is called.....');
    _orderList = await Provider.of<OrderProvider>(context, listen: false)
        .getAllOrder(loadMore: loadMore);
  }

  @override
  Widget build(BuildContext context) {
    OrderProvider orderProvider = Provider.of<OrderProvider>(context);

    return orderProvider.loadingOrders
        ? Center(
            child: CupertinoActivityIndicator(
              radius: 15,
            ),
          )
        : orderProvider.ordersErrorMsg != ''
            ? ShowError(
                errorMsg: orderProvider.ordersErrorMsg,
                onReload: () {
                  _getAllOrders(false);
                })
            : _orderList.length == 0
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('You have no any order yet.'),
                    ),
                  )
                : Container(
                    height: MediaQuery.of(context).size.height,
                    child: ListView(
                      children: [
                        ..._orderList.map((e) => OrderCard(
                              order: e,
                            )),
                        if (_orderList.length < orderProvider.totalElements)
                          orderProvider.loadingMore
                              ? Center(
                                  child: CupertinoActivityIndicator(),
                                )
                              : CupertinoButton(
                                  child: Text('Load more'),
                                  onPressed: () => _getAllOrders(true),
                                ),
                      ],
                    ),
                  );
  }
}
