import 'package:designers_hub_modile_app/Model/cart_details.dart';
import 'package:designers_hub_modile_app/Model/design.dart';
import 'package:designers_hub_modile_app/Model/fabric.dart';
import 'package:designers_hub_modile_app/Provider/order_provider.dart';
import 'package:designers_hub_modile_app/Provider/design_provider.dart';
import 'package:designers_hub_modile_app/helper/constants.dart';
import 'package:designers_hub_modile_app/helper/currency.dart';
import 'package:designers_hub_modile_app/widget/common/buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  double totalPrice = 0;
  bool buttonPress = true;
  TextEditingController _quantityEditingController = new TextEditingController();


  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Provider.of<DesignProvider>(context, listen: false)
          .getDesign(widget.cartDetails.design.id);
    });
    setState(() {
      _fabricsName = widget.cartDetails.fabric.name;
      quantity = widget.cartDetails.quantity.toInt();
      _quantityEditingController.text = quantity.toString();
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





  @override
  Widget build(BuildContext context) {

    OrderProvider orderProvider = Provider.of<OrderProvider>(context);
    Design _design = widget.cartDetails.design;
    double _designPrice = widget.cartDetails.design.price;
    double screenHeight = MediaQuery.of(context).size.height/5.1;

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
                                      widget.cartDetails.fabric=_fabric;
                                      orderProvider.addToCart(widget.cartDetails,quantity.toDouble());

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
        height: screenHeight,
        padding: EdgeInsets.only(top: 5,left: 5,right: 5,),

        child: Row(
          children: [
            Container(
              // decoration: BoxDecoration(border: Border.all(color: Colors.red,width: 1)),
                height: 97,
                width: 80,
                child: Image.network(
                  "$IMAGE_URL${widget.cartDetails.design.thumbnail}",
                  fit: BoxFit.fill,
                )),
            Expanded(
                child: Container(
                  // decoration: BoxDecoration(border: Border.all(color: Colors.red,width: 1)),
              padding: EdgeInsets.only(left: 10),
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${widget.cartDetails.design.name}",style: Theme.of(context).textTheme.subtitle1,),
                      GestureDetector(
                        child:  Icon(Icons.delete,color: Colors.black,) ,
                        onTap:(){
                        orderProvider.deleteDesign(widget.cartDetails.design.id);
                        },
                      )
                    ],
                  ),
                  SizedBox(height: 5,),

                  Container(
                    // decoration: BoxDecoration(border: Border.all(color: Colors.red,width: 2.0)),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [

                        //choose fabric
                        widget.cartDetails.design.designType.requiredFabric?
                        GestureDetector(
                          child: Container(
                            padding: EdgeInsets.only(left: 5),
                            height: 40,
                            decoration: BoxDecoration(
                                border:
                                Border.all(color: Colors.black, width: 1)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _fabricsName,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                Container(
                                  child:  Icon(
                                    CupertinoIcons.pencil,
                                  ),
                                )
                              ],
                            ),
                          ),
                          onTap: (){showModal();},
                        ):SizedBox(height: 40,),

                        SizedBox(height:5,),

                        Container(
                            // width: 130,
                            height: 30,
                            // margin: EdgeInsets.only(top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  child: Container(
                                    color: Theme.of(context).primaryColor,
                                    child: Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                  onTap: () {
                                    if(quantity>1){
                                      setState(() {
                                        quantity = quantity-1;
                                        _quantityEditingController.text = quantity.toString();
                                      });
                                      orderProvider.addToCart(widget.cartDetails, quantity.toDouble());
                                      FocusScope.of(context).unfocus();
                                    }

                                  },
                                ),

                                Container(
                                  width: 80,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black,width: .5)
                                  ),
                                  height: 30,
                                  child: TextField(
                                    controller: _quantityEditingController,
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.headline4,
                                    onChanged: (value) {
                                      if(value.isEmpty){
                                        setState(() {
                                          quantity=1;
                                          orderProvider.addToCart(widget.cartDetails, quantity.toDouble());
                                          // _quantityEditingController.text = quantity.toString();
                                        });
                                        return;
                                      }else{
                                        try{
                                          double q = double.parse(value);
                                          orderProvider.addToCart(widget.cartDetails, q);
                                          setState(() {
                                            quantity = q.toInt();
                                            // _quantityEditingController.text = quantity.toString();
                                          });

                                        }catch(error){
                                          return;
                                        }
                                      }
                                    },
                                  ),
                                ),

                                GestureDetector(
                                  child: Container(
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                    color: Theme.of(context).primaryColor,

                                  ),
                                  onTap: () {
                                    setState(() {
                                      quantity = quantity+1;
                                      _quantityEditingController.text = quantity.toString();
                                    });
                                    orderProvider.addToCart(widget.cartDetails, quantity.toDouble());
                                    FocusScope.of(context).unfocus();

                                    // cartDesignProvider.addToCart(widget.cartDetails, widget.cartDetails.quantity + 1);
                                  },
                                ),

                                Text('')

                              ],
                            )
                        ),
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
