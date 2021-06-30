import 'package:designers_hub_modile_app/Model/cart_details.dart';
import 'package:designers_hub_modile_app/Model/design.dart';
import 'package:designers_hub_modile_app/Model/fabric.dart';
import 'package:designers_hub_modile_app/Provider/order_provider.dart';
import 'package:designers_hub_modile_app/Provider/design_provider.dart';
import 'package:designers_hub_modile_app/Screen/cart_screen.dart';
import 'package:designers_hub_modile_app/helper/constants.dart';
import 'package:designers_hub_modile_app/helper/currency.dart';
import 'package:designers_hub_modile_app/widget/common/CustomAppBar.dart';
import 'package:designers_hub_modile_app/widget/common/buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int id;

  const ProductDetailsScreen({required this.id});

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String _imageUrl = '';
  TextEditingController _quantityEditingController = new TextEditingController(text: '1');


  @override
  void initState() {

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Provider.of<DesignProvider>(context, listen: false).getDesign(widget.id);
    });

  }

  double _quantityPrice = 0;
  String _fabricsName = "Choose Fabrics";
  Fabric _fabric = Fabric(available: false, baseColor: "", descriptions: "", disabled: false, favCount: 0, id: 0, name:"", price: 0, slug: "", fabricMixings: [], thumbnail: "");
  int quantity = 1;

  // List<CartDetails> cartDetailList = [];

  @override
  Widget build(BuildContext context) {
    DesignProvider designProvider = Provider.of<DesignProvider>(context);
    OrderProvider cartDesignProvider = Provider.of<OrderProvider>(context);

    List<String> imageList = [
      designProvider.design.thumbnail,
      ...designProvider.design.designImages.map((e) => e.image)
    ];

    double _designPrice = designProvider.design.price;
    Design _design = designProvider.design;


    void calculateTotalPrice(int q){

      if(designProvider.design.designType.requiredFabric){
        setState(() {
          _quantityPrice =  _designPrice + (q*_fabric.price);
        });
      }else {
        setState(() {
          _quantityPrice =
              q * _designPrice;
        });
      }
    }

    void showModal(){
      showModalBottomSheet<void>(
          context: context,
          elevation: 10.0,
          builder: (BuildContext context) {
            return Container(
              height: (MediaQuery.of(context)
                  .size
                  .height),
              color: Colors.white70,
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        left: 5, top: 10, bottom: 10),
                    child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment
                            .spaceBetween,
                        children: [
                          _design.fabrics.isEmpty? Text('No Fabrics Available Fabrics',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1)
                          :Text('Available Fabrics',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1),
                          GestureDetector(
                            onTap: () =>
                                Navigator.pop(
                                    context),
                            child: Icon(
                              Icons.close,
                              color: Colors.red,
                            ),
                          )
                        ]),
                  ),
                  ..._design.fabrics
                      .map((e) => Container(
                    margin: EdgeInsets.only(
                        left: 10, bottom: 5),
                    child: Row(
                      children: [
                        Expanded(
                            child:  Image
                                .network(
                              "$IMAGE_URL${e.thumbnail}",
                              fit: BoxFit
                                  .fill,
                            )),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(left: 10, top: 5, bottom: 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    '${e.name}',
                                    style: Theme.of(context).textTheme.bodyText1),
                                Text(
                                  'Base color : ${e.baseColor}',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                Text(
                                    '$CURRENCY${e.price} / Yard',
                                    style: Theme.of(context).textTheme.headline6),

                                secondaryButton((){
                                  setState(() {
                                    _fabricsName = e.name;
                                    _fabric = e;

                                });
                                  calculateTotalPrice(quantity);
                                  Navigator.pop(context);
                                  }, "Select", context
                                ),
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

    void showErrorMassage(String msg){
      showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Missing value',style: Theme.of(context).textTheme.headline4,),
        content:  Text('$msg',style: Theme.of(context).textTheme.headline6),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
         ],
        ),
      );
    }




    return Scaffold(
        appBar: buildCustomAppbar('DESIGN DETAILS',context),
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
                                        margin: EdgeInsets.only(bottom: 5,right: 5),
                                        child: GestureDetector(
                                          onTap: () {

                                            setState(() {
                                              _imageUrl = e;
                                            });

                                          },
                                          child: Image.network(
                                            "$IMAGE_URL${e}",
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ))
                                ],
                              ),
                            ),
                            Container(
                                // decoration: BoxDecoration( border: Border.all(color: Colors.greenAccent,width: 2.0),),
                                height: 300,
                                width: (MediaQuery.of(context).size.width / 5) * 4 - 25,
                                child: _imageUrl.isEmpty
                                    ? Image.network(
                                        "$IMAGE_URL${_design.thumbnail}",
                                        fit: BoxFit.fill,
                                      )
                                    : Image.network(
                                        "$IMAGE_URL${_imageUrl}",
                                        fit: BoxFit.fill
                                      )
                            )
                          ],
                        ),
                      ),

                      //name
                      Container(
                        // decoration: BoxDecoration(border: Border.all(color: Colors.greenAccent,width: 2.0)),
                        margin: EdgeInsets.only(top: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${_design.name}',
                                style: Theme.of(context).textTheme.headline1),
                          ],
                        ),
                      ),

                      Divider(),

                      //choose fabrics
                      designProvider.design.designType.requiredFabric?
                      Container(
                        // decoration: BoxDecoration(border: Border.all(color: Colors.red,width: 2.0)),

                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Fabrics :  ',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            GestureDetector(
                              child: Container(
                                margin: EdgeInsets.only(top: 5),
                                padding: EdgeInsets.only(left: 5),
                                height: 40,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(_fabricsName,style: Theme.of(context).textTheme.bodyText1,),
                                    Icon(CupertinoIcons.pencil)
                                  ],
                                ),
                              ),
                              onTap: showModal,
                            )


                          ],
                        ),
                      ):SizedBox(height: 0,),


                      SizedBox(height: 20,),

                      //quantity and price
                      Container(
                        // decoration: BoxDecoration(border: Border.all(color: Colors.red,width: 2.0)),

                        child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Quantity : ',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        // width: 130,
                                          height: 30,

                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              GestureDetector(
                                                child: Container(
                                                  // decoration: BoxDecoration(
                                                  //     border: Border.all(color: Colors.black,width: .5)
                                                  // ),
                                                  color: Theme.of(context).primaryColor,
                                                  child: Icon(
                                                    Icons.remove,
                                                    size: 30,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                onTap: () {
                                                  if(quantity>1)
                                                    setState(() {
                                                      quantity = quantity-1;
                                                    });
                                                  calculateTotalPrice(quantity);
                                                  _quantityEditingController.text = quantity.toString();

                                                },
                                              ),


                                              Container(
                                                width: 50,
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.black,width: .5)
                                                ),

                                                child: TextField(
                                                  textAlign: TextAlign.center,
                                                  controller: _quantityEditingController,
                                                  keyboardType: TextInputType.number,
                                                  style:
                                                  Theme.of(context).textTheme.headline4,

                                                  onChanged: (value) {
                                                    if (value.isEmpty){
                                                      setState(() {
                                                        quantity=1;
                                                      });
                                                      return;
                                                    }

                                                    quantity = double.parse(value).toInt();
                                                    calculateTotalPrice(quantity);
                                                  },
                                                ),
                                              ),



                                              GestureDetector(
                                                child: Container(
                                                  // decoration: BoxDecoration(
                                                  //     border: Border.all(color: Colors.black,width: .5)
                                                  // ),
                                                  child: Icon(
                                                    Icons.add,
                                                    size: 30,
                                                    color: Colors.white,
                                                  ),
                                                  color: Theme.of(context).primaryColor,
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    quantity = quantity+1;
                                                  });
                                                  _quantityEditingController.text = quantity.toString();

                                                  calculateTotalPrice(quantity);
                                                },
                                              ),

                                            ],
                                          )
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('$CURRENCY $_quantityPrice',style:Theme.of(context).textTheme.headline2),
                                          Text(
                                              '$CURRENCY $_designPrice/quantity',
                                              style: Theme.of(context).textTheme.subtitle1
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),

                              ],
                            ),


                      ),

                      SizedBox(height: 90,)
                    ],
                  ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,),
                width: MediaQuery.of(context).size.width,
                child: secondaryButton(() {
                  if(designProvider.design.designType.requiredFabric){
                    if(_fabricsName!="Choose Fabrics" && quantity > 0){

                      cartDesignProvider.addToCart(
                          CartDetails(
                              designPrice: _designPrice,
                              id: 1,
                              totalPrice: _quantityPrice+_fabric.price,
                              quantity: quantity.toDouble(),
                              design: _design,
                              fabric: _fabric,
                              note: "note",
                              fabricPrice: _fabric.price
                          ),
                        quantity.toDouble()
                      );
                      print(" length---->${cartDesignProvider.cart.cartDetailsList.length}");
                    }
                    else{
                      showErrorMassage("Choose fabric and Quantity");
                    }
                  }else{
                    if(quantity > 0){
                      cartDesignProvider.addToCart(
                          CartDetails(
                              designPrice: _designPrice,
                              id: 1,
                              totalPrice: _quantityPrice+_fabric.price,
                              quantity: quantity.toDouble(),
                              design: _design,
                              fabric: _fabric,
                              note: "note",
                              fabricPrice: _fabric.price
                          ),
                        quantity.toDouble()
                      );
                      print(" length---->${cartDesignProvider.cart.cartDetailsList.length}");
                    }
                    else{
                      showErrorMassage("Provide Quantity");
                    }
                  }


                 FocusScope.of(context).unfocus();

                }, "ADD TO CART", context)),
          ),
        ]));
  }
}
