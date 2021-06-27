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
  int page = 0, size = 10;
  bool loadingOrders = true;
  bool loadMore = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      _getAllOrders(page, size);
    });

  }


  _getAllOrders(int page, int size) async {
    setState(() {
      loadingOrders = true;
    });
    print('constractor is called.....');
    _orderList = await Provider.of<OrderProvider>(context, listen: false)
          .getAllOrder(page, size);

    setState(() {
      loadingOrders = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    OrderProvider orderProvider = Provider.of<OrderProvider>(context);

    return loadingOrders
        ? Center(
          child: CupertinoActivityIndicator(
            radius: 15,
          ),
        )
        : orderProvider.ordersErrorMsg != ''
        ? ShowError(
        errorMsg: orderProvider.ordersErrorMsg,
        onReload: (){_getAllOrders(page, size);})
        : _orderList.length == 0 ?
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('You have no any order yet.'),
          ),
        ) : Container(
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: [
              ..._orderList.map((e) => OrderCard(
                order: e,
              )),
              if (_orderList.length < orderProvider.totalElements)
                loadMore
                    ? Center(
                  child: CupertinoActivityIndicator(),
                )
                    : CupertinoButton(
                  child: Text('Load more'),
                  onPressed: () async {
                    page = page + 1;
                    loadMore = true;
                    List<Order> newOrders =
                    await orderProvider.getAllOrder(page, size);
                    setState(() {
                      _orderList.addAll(newOrders);
                    });
                    loadMore = false;
                  },
                ),
            ],
          ),
    );
  }
}
