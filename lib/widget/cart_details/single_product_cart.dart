import 'package:designers_hub_modile_app/Model/cart_details.dart';
import 'package:designers_hub_modile_app/Model/design.dart';
import 'package:designers_hub_modile_app/Model/fabric.dart';
import 'package:designers_hub_modile_app/Provider/design_provider.dart';
import 'package:designers_hub_modile_app/helper/constants.dart';
import 'package:designers_hub_modile_app/helper/currency.dart';
import 'package:designers_hub_modile_app/widget/common/buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingleProductCart extends StatefulWidget {
  final CartDetails cartDetails;

  SingleProductCart({required this.cartDetails});

  @override
  _SingleProductCartState createState() => _SingleProductCartState();
}

class _SingleProductCartState extends State<SingleProductCart> {
  String _fabricsName = "";
  int quantity = 0;

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Provider.of<DesignProvider>(context, listen: false)
          .getDesign(widget.cartDetails.design.id);
    });
    setState(() {
      _fabricsName = widget.cartDetails.fabric.name;
      quantity = widget.cartDetails.quantity;
    });
  }

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

  double _quantityPrice = 0;

  @override
  Widget build(BuildContext context) {
    DesignProvider designProvider = Provider.of<DesignProvider>(context);
    Design _design = designProvider.design;
    double _designPrice = designProvider.design.price;

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

    return Card(
      elevation: 3,
      child: Container(
        // decoration: BoxDecoration(border: Border.all(color: Colors.red,width: 2.0)),
        height: MediaQuery.of(context).size.height / 5,
        padding: EdgeInsets.all(5),

        child: Row(
          children: [
            Container(
                height: 70,
                width: 70,
                child: Image.network(
                  "$IMAGE_URL${widget.cartDetails.design.thumbnail}",
                  fit: BoxFit.fill,
                )),
            Expanded(
                child: Container(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${widget.cartDetails.design.name}"),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    // decoration: BoxDecoration(border: Border.all(color: Colors.red,width: 2.0)),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        //choose fabric
                        designProvider.design.designType.requiredFabric?
                        GestureDetector(
                          child: Container(
                            padding: EdgeInsets.only(left: 5),
                            height: 30,
                            decoration: BoxDecoration(
                                border:
                                Border.all(color: Colors.black, width: 1)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _fabricsName,
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                                Container(
                                  child:  Icon(
                                    CupertinoIcons.pencil,
                                    size: 15,
                                  ),
                                )
                              ],
                            ),
                          ),
                          onTap: showModal,
                        ):SizedBox(height: 0,),

                        Container(
                            // width: 130,
                            height: 30,
                            // margin: EdgeInsets.only(top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  child: Container(
                                    color: Theme.of(context).primaryColor,
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      quantity = quantity + 1;
                                    });
                                  },
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width: 100,
                                  child: TextField(
                                    controller: TextEditingController()
                                      ..text = quantity.toString(),
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                    onChanged: (value) {
                                      quantity =
                                          value.isEmpty ? 0 : int.parse(value);
                                      setState(() {
                                        _quantityPrice =
                                            quantity * _designPrice;
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  child: Container(
                                    child: Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                    ),
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      quantity = quantity - 1;
                                    });
                                  },
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}