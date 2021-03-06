import 'package:designers_hub_modile_app/Model/order.dart';
import 'package:designers_hub_modile_app/Provider/order_provider.dart';
import 'package:designers_hub_modile_app/widget/order/item_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderDetailsScreen extends StatefulWidget {
  int id;

  OrderDetailsScreen({required this.id});

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  bool showModalSheet = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      Provider.of<OrderProvider>(context, listen: false)
          .getOrderByOrderId(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    OrderProvider orderProvider = Provider.of<OrderProvider>(context);
    Order order = orderProvider.order;

    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: Stack(
        children: [
          orderProvider.loadingOrder
              ? Center(
                  child: CupertinoActivityIndicator(),
                )
              : Container(
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        padding: EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Items(${order.cart.cartDetailsList.length})",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            // primaryButton((){}, "Reorder", context)
                          ],
                        ),
                      ),
                      Divider(),
                      Container(
                        height: MediaQuery.of(context).size.height - 150,
                        child: ListView(
                          children: [
                            ...order.cart.cartDetailsList
                                .map((e) => ItemCard(e))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
          showModalSheet
              ? Positioned(
                  right: 0,
                  bottom: 0,
                  left: 0,
                  child: Card(
                      elevation: 3,
                      child: orderProvider.loadingOrder
                          ? Center(
                              child: CupertinoActivityIndicator(),
                            )
                          : Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 2.5,
                              padding: EdgeInsets.only(left: 5, right: 5),
                              child: ListView(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                      left: 5,
                                      top: 10,
                                    ),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Order Status',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13),
                                          ),
                                          GestureDetector(
                                            onTap: () => setState(() {
                                              showModalSheet = false;
                                            }),
                                            child: Icon(
                                              Icons.arrow_circle_down_sharp,
                                            ),
                                          )
                                        ]),
                                  ),
                                  Divider(),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 5, top: 10, bottom: 10),
                                    child: CustomRow(
                                        "Status", "${order.orderStatus.value}"),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 5, top: 10, bottom: 10),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Total Amount',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13),
                                          ),
                                        ]),
                                  ),
                                  Divider(),
                                  Container(
                                    child: Column(
                                      children: [
                                        CustomRow("Total Price",
                                            "${order.cart.totalPrice}"),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        CustomRow("Printing price",
                                            "${order.cart.printingCost}"),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        CustomRow("Discount",
                                            "${order.cart.discount}"),
                                        Divider(),
                                        CustomRow("Grand Total",
                                            "${order.cart.grandTotal}"),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                            )))
              : Positioned(
                  right: 0,
                  bottom: 0,
                  child: IconButton(
                    icon: Icon(Icons.arrow_circle_up_outlined),
                    onPressed: () => setState(() {
                      showModalSheet = true;
                    }),
                  ),
                )
        ],
      ),
    );
  }
}
// Widget PaymentInfo(String title, String price){
//
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//       Text(title),
//       Text(price,),
//     ],
//   );
// }
