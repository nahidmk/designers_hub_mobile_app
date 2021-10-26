import 'dart:ui';

import 'package:bot_toast/bot_toast.dart';
import 'package:designers_hub_modile_app/Model/cart_details.dart';
import 'package:designers_hub_modile_app/Model/design.dart';
import 'package:designers_hub_modile_app/Model/fabric.dart';
import 'package:designers_hub_modile_app/Provider/design_provider.dart';
import 'package:designers_hub_modile_app/Provider/order_provider.dart';
import 'package:designers_hub_modile_app/helper/constants.dart';
import 'package:designers_hub_modile_app/helper/currency.dart';
import 'package:designers_hub_modile_app/widget/common/CustomAppBar.dart';
import 'package:designers_hub_modile_app/widget/common/buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int id;

  const ProductDetailsScreen({required this.id});

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String _imageUrl = '';
  TextEditingController _quantityEditingController =
      new TextEditingController(text: '1');

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Provider.of<DesignProvider>(context, listen: false).getDesign(widget.id);
    });
  }

  double _quantityPrice = 0;
  String _fabricsName = "Choose Fabrics";
  Fabric _fabric = Fabric(
      available: false,
      baseColor: "",
      descriptions: "",
      disabled: false,
      favCount: 0,
      id: 0,
      name: "",
      price: 0,
      slug: "",
      fabricMixings: [],
      thumbnail: "");
  int quantity = 1;
  BoxDecoration _boxDecoration =
      BoxDecoration(border: Border.all(color: Colors.black, width: 2));

  // List<CartDetails> cartDetailList = [];

  @override
  Widget build(BuildContext context) {
    DesignProvider designProvider = Provider.of<DesignProvider>(context);
    OrderProvider orderProvider = Provider.of<OrderProvider>(context);

    List<String> imageList = [
      designProvider.design.thumbnail,
      ...designProvider.design.designImages.map((e) => e.image)
    ];

    double _designPrice = designProvider.design.price;
    Design _design = designProvider.design;

    void calculateTotalPrice(int q) {
      if (designProvider.design.designType.requiredFabric) {
        setState(() {
          _quantityPrice = _designPrice + (q * _fabric.price);
        });
      } else {
        setState(() {
          _quantityPrice = q * _designPrice;
        });
      }
    }

    void showModal() {
      showModalBottomSheet<void>(
          context: context,
          elevation: 10.0,
          builder: (BuildContext context) {
            return Container(
              height: (MediaQuery.of(context).size.height),
              color: Colors.white70,
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 5, top: 10, bottom: 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _design.fabrics.isEmpty
                              ? Text('No Fabrics Available Fabrics',
                                  style: Theme.of(context).textTheme.bodyText1)
                              : Text('Available Fabrics',
                                  style: Theme.of(context).textTheme.bodyText1),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Icon(
                              Icons.close,
                              color: Colors.red,
                            ),
                          )
                        ]),
                  ),
                  if (designProvider.loadingList)
                    Center(
                      child: CupertinoActivityIndicator(),
                    ),
                  ..._design.fabrics.map((e) => Container(
                        margin: EdgeInsets.only(left: 10, bottom: 5),
                        child: Row(
                          children: [
                            Expanded(
                                child: Image.network(
                              "$IMAGE_URL${e.thumbnail}",
                              fit: BoxFit.fill,
                            )),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(
                                    left: 10, top: 5, bottom: 5),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('${e.name}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1),
                                    Text(
                                      'Base color : ${e.baseColor}',
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    Text('$CURRENCY${e.price} / Yard',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6),
                                    secondaryButton(() {
                                      setState(() {
                                        _fabricsName = e.name;
                                        _fabric = e;
                                      });
                                      calculateTotalPrice(quantity);
                                      Navigator.pop(context);
                                    }, "Select", context),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            );
          });
    }

    showOverLay() async {
      OverlayState? overlayState = Overlay.of(context);
      OverlayEntry overlayEntry = OverlayEntry(
          builder: (context) => Positioned(
              bottom: 80,
              left: 0,
              right: 0,
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'This design has already been added',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ))));
      overlayState!.insert(overlayEntry);
      await Future.delayed(Duration(seconds: 2));
      overlayEntry.remove();
    }

    void _showToast(BuildContext context) {
      final scaffold = ScaffoldMessenger.of(context);
      scaffold.showSnackBar(
        SnackBar(
          content: const Text('This Design has already been added'),
          action: SnackBarAction(
              label: '', onPressed: scaffold.hideCurrentSnackBar),
          duration: Duration(milliseconds: 1500),
        ),
      );
    }

    return Scaffold(
        appBar: buildCustomAppbar('DESIGN DETAILS', context),
        body: Stack(children: [
          Container(
            width: MediaQuery.of(context).size.width,
            // decoration: BoxDecoration(border: Border.all(color: Colors.red,width: 2.0)),
            padding: EdgeInsets.all(10),
            child: designProvider.loading
                //loading image
                ? Container(
                    child: Image.asset(
                    "assets/images/placeholder.jpg",
                    fit: BoxFit.fill,
                  ))
                : ListView(
                    children: [
                      //image
                      Container(
                        height: 200,
                        padding: EdgeInsets.all(2),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // decoration: BoxDecoration(border: Border.all(color: Colors.greenAccent,width: 2.0)),
                              height: 300,
                              width: MediaQuery.of(context).size.width / 5,
                              child: ListView(
                                children: [
                                  ...imageList.map((e) => Container(
                                        margin: EdgeInsets.only(
                                            bottom: 5, right: 5),
                                        decoration: _boxDecoration,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _imageUrl = e;
                                            });
                                          },
                                          child: FadeInImage(
                                            placeholder: AssetImage(
                                                'assets/images/placeholder.jpg'),
                                            image: NetworkImage("$IMAGE_URL$e"),
                                          ),

                                          // child: Image.network(
                                          //   "$IMAGE_URL${e}",
                                          //   fit: BoxFit.fill,
                                          // ),
                                        ),
                                      ))
                                ],
                              ),
                            ),
                            Container(
                                // decoration: BoxDecoration( border: Border.all(color: Colors.greenAccent,width: 2.0),),
                                height: 300,
                                width: (MediaQuery.of(context).size.width / 5) *
                                        4 -
                                    25,
                                child: _imageUrl.isEmpty
                                    ? Image.network(
                                        "$IMAGE_URL${_design.thumbnail}",
                                        fit: BoxFit.fill,
                                      )
                                    : Image.network("$IMAGE_URL${_imageUrl}",
                                        fit: BoxFit.fill))
                          ],
                        ),
                      ),

                      //name
                      Container(
                        // decoration: BoxDecoration(border: Border.all(color: Colors.greenAccent,width: 2.0)),
                        margin: EdgeInsets.only(top: 20),
                        child: Text('${_design.name}',
                            style: TextStyle(
                                fontSize: 27,
                                fontWeight: FontWeight.w700,
                                color: Colors.black54)),
                      ),

                      Divider(),

                      //choose fabrics
                      designProvider.design.designType.requiredFabric
                          ? Container(
                              // decoration: BoxDecoration(border: Border.all(color: Colors.red,width: 2.0)),

                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Fabrics :  ',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                  GestureDetector(
                                    child: Container(
                                      margin: EdgeInsets.only(top: 5),
                                      padding: EdgeInsets.only(left: 5),
                                      height: 40,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            _fabricsName,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black),
                                          ),
                                          Icon(CupertinoIcons.pencil)
                                        ],
                                      ),
                                    ),
                                    onTap: showModal,
                                  )
                                ],
                              ),
                            )
                          : SizedBox(
                              height: 0,
                            ),

                      SizedBox(
                        height: 20,
                      ),

                      //quantity and price
                      Container(
                        // decoration: BoxDecoration(border: Border.all(color: Colors.red,width: 2.0)),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Quantity : ',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      height: 30,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          GestureDetector(
                                            child: Container(
                                              // decoration: BoxDecoration(
                                              //     border: Border.all(color: Colors.black,width: .5)
                                              // ),
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              child: Icon(
                                                Icons.remove,
                                                size: 30,
                                                color: Colors.white,
                                              ),
                                            ),
                                            onTap: () {
                                              if (quantity > 1)
                                                setState(() {
                                                  quantity = quantity - 1;
                                                });
                                              calculateTotalPrice(quantity);
                                              _quantityEditingController.text =
                                                  quantity.toString();
                                              FocusScope.of(context).unfocus();
                                            },
                                          ),
                                          Container(
                                            width: 80,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: .5)),
                                            child: TextField(
                                              textAlign: TextAlign.center,
                                              controller:
                                                  _quantityEditingController,
                                              keyboardType:
                                                  TextInputType.number,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4,
                                              onChanged: (value) {
                                                if (value.isEmpty) {
                                                  setState(() {
                                                    quantity = 1;
                                                    // _quantityEditingController.text = quantity.toString();
                                                  });
                                                  return;
                                                }

                                                quantity =
                                                    double.parse(value).toInt();
                                                calculateTotalPrice(quantity);
                                              },
                                            ),
                                          ),
                                          GestureDetector(
                                            child: Container(
                                              child: Icon(
                                                Icons.add,
                                                size: 30,
                                                color: Colors.white,
                                              ),
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            onTap: () {
                                              setState(() {
                                                quantity = quantity + 1;
                                              });
                                              _quantityEditingController.text =
                                                  quantity.toString();

                                              calculateTotalPrice(quantity);
                                              FocusScope.of(context).unfocus();
                                            },
                                          ),
                                        ],
                                      )),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('$CURRENCY $_quantityPrice',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2),
                                      Text('$CURRENCY $_designPrice/quantity',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      Divider(),

                      Container(
                        // decoration: BoxDecoration(border: Border.all(color: Colors.greenAccent,width: 2.0)),
                        child: Text('Description : ',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.black)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        // decoration: BoxDecoration(border: Border.all(color: Colors.greenAccent,width: 2.0)),
                        width: MediaQuery.of(context).size.width,
                        child: Text('${_design.descriptions}',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w300,
                                color: Colors.black)),
                      ),

                      SizedBox(
                        height: 90,
                      )
                    ],
                  ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                width: MediaQuery.of(context).size.width,
                child: secondaryButton(() {
                  int oldLength = orderProvider.cart.cartDetailsList.length;
                  if (designProvider.design.designType.requiredFabric) {
                    if (_fabricsName != "Choose Fabrics" && quantity > 0) {
                      orderProvider.addToCart(
                          CartDetails(
                              designPrice: _designPrice,
                              id: 1,
                              totalPrice: _quantityPrice + _fabric.price,
                              quantity: quantity.toDouble(),
                              design: _design,
                              fabric: _fabric,
                              note: "note",
                              fabricPrice: _fabric.price),
                          quantity.toDouble());

                      if (oldLength ==
                          orderProvider.cart.cartDetailsList.length) {
                        BotToast.showText(
                            text: "This design has already been added");
                      }
                      print(
                          " length---->${orderProvider.cart.cartDetailsList.length}");
                    } else {
                      BotToast.showText(text: "Please choose a Fabrics");
                    }
                  } else {
                    if (quantity > 0) {
                      orderProvider.addToCart(
                          CartDetails(
                              designPrice: _designPrice,
                              id: 1,
                              totalPrice: _quantityPrice + _fabric.price,
                              quantity: quantity.toDouble(),
                              design: _design,
                              fabric: _fabric,
                              note: "note",
                              fabricPrice: _fabric.price),
                          quantity.toDouble());
                      print(
                          " length---->${orderProvider.cart.cartDetailsList.length}");
                      if (oldLength ==
                          orderProvider.cart.cartDetailsList.length) {
                        BotToast.showText(
                            text: "This design has already been added");
                      }
                    } else {
                      BotToast.showText(text: "Provide the quantity");
                    }
                  }

                  FocusScope.of(context).unfocus();
                }, "ADD TO CART", context)),
          ),
        ]));
  }
}
