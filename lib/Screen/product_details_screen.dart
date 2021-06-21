import 'package:designers_hub_modile_app/Model/cart_details.dart';
import 'package:designers_hub_modile_app/Model/design.dart';
import 'package:designers_hub_modile_app/Model/fabric.dart';
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


  @override
  void initState() {

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Provider.of<DesignProvider>(context, listen: false).getDesign(widget.id);
    });

  }

  double _quantityPrice = 0;
  String _fabricsName = "Choose Fabrics";
  Fabric _fabric = Fabric(available: false, baseColor: "", descriptions: "", disabled: false, favCount: 0, id: 0, name:"", price: 0, slug: "", fabricMixings: [], thumbnail: "");
  var quantity = 0;

  List<CartDetails> cartDetailList = [];

  @override
  Widget build(BuildContext context) {
    DesignProvider designProvider = Provider.of<DesignProvider>(context);

    List<String> imageList = [
      designProvider.design.thumbnail,
      ...designProvider.design.designImages.map((e) => e.image)
    ];

    double _designPrice = designProvider.design.price;
    Design _design = designProvider.design;


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

    void showErrorMassage(){
      showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Missing value'),
        content: const Text('Select the Fabrics and quantity'),
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
        appBar: buildCustomAppbar('DESIGN DETAILS',context,cartDetailList),
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
                        height: 250,
                        padding: EdgeInsets.all(2),
                        child: Row(
                          children: [
                            Container(
                              // decoration: BoxDecoration(border: Border.all(color: Colors.greenAccent,width: 2.0)),
                              height: 300,
                              width: MediaQuery.of(context).size.width / 5,
                              child: ListView(
                                children: [
                                  ...imageList.map((e) => Container(
                                        margin: EdgeInsets.all(5),
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
                      Container(
                        // decoration: BoxDecoration(border: Border.all(color: Colors.red,width: 2.0)),
                        height: 80,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Fabrics :  ',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              padding: EdgeInsets.only(left: 5),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1)),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(_fabricsName,style: Theme.of(context).textTheme.bodyText1,),
                                  IconButton(
                                      onPressed: showModal, icon: Icon(CupertinoIcons.pencil))

                                ],
                              ),
                            ),


                          ],
                        ),
                      ),

                      //quantity and price
                      Container(
                        // decoration: BoxDecoration(border: Border.all(color: Colors.red,width: 2.0)),
                        margin: EdgeInsets.only(top: 10),
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

                                        width: 80,

                                        child: TextField(
                                          style: Theme.of(context).textTheme.headline4,
                                          onChanged: (value){
                                            quantity = value.isEmpty?0:int.parse(value);
                                            setState(() {
                                              _quantityPrice = quantity * _designPrice;
                                            });
                                          },
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                          ),
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.right,

                                        ),
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
                  if(_fabricsName!="Choose Fabrics" && quantity > 0){
                    cartDetailList.add(
                      CartDetails(designPrice: _designPrice, id: 1, totalPrice: _quantityPrice+_fabric.price, quantity: quantity, design: _design, fabric: _fabric, note: "note", fabricPrice: _fabric.price)
                    );
                    print(" length---->${cartDetailList.length}");
                  }
                  else{
                    showErrorMassage();
                  }
                }, "ADD TO CART", context)),
          ),
        ]));
  }
}
