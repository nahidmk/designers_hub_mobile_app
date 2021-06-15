import 'package:designers_hub_modile_app/Model/design.dart';
import 'package:designers_hub_modile_app/Provider/design_provider.dart';
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

  @override
  Widget build(BuildContext context) {
    DesignProvider designProvider = Provider.of<DesignProvider>(context);

    List<String> imageList = [
      designProvider.design.thumbnail,
      ...designProvider.design.designImages.map((e) => e.image)
    ];

    double _designPrice = designProvider.design.price;

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
                          Text('Available Fabrics',
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
                  ...designProvider.design.fabrics
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
                                    '$CURRENCY${e.pricePerYard} / Yard',
                                    style: Theme.of(context).textTheme.headline6),

                                secondaryButton((){
                                  setState(() {
                                    _fabricsName = e.name;
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

    return Scaffold(
        appBar: buildCustomAppbar('DESIGN DETAILS',context),
        body: Stack(children: [
          Container(
            width: MediaQuery.of(context).size.width,
            // decoration: BoxDecoration(border: Border.all(color: Colors.red,width: 2.0)),
            padding: EdgeInsets.all(10),
            child: designProvider.loading
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
                                        "$IMAGE_URL${designProvider.design.thumbnail}",
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
                            Text('${designProvider.design.name}',
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
                              decoration: BoxDecoration(border: Border.all(color: Colors.grey,width: 0.5)),
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
                                          onChanged: (value){
                                            setState(() {
                                              _quantityPrice = int.parse(value) * _designPrice;
                                            });
                                            print("value --->$_quantityPrice");
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
                  // _fabricsName=="Choose Fabrics"?
                }, "ADD TO CART", context)),
          ),
        ]));
  }
}
