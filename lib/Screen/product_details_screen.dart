import 'package:designers_hub_modile_app/Model/design.dart';
import 'package:designers_hub_modile_app/Provider/design_provider.dart';
import 'package:designers_hub_modile_app/helper/constants.dart';
import 'package:designers_hub_modile_app/helper/currency.dart';
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

  @override
  Widget build(BuildContext context) {

    DesignProvider designProvider = Provider.of<DesignProvider>(context);


    List<String> imageList = [
      designProvider.design.thumbnail, ...designProvider.design.designImages.map((e) => e.image)
    ];

    return Scaffold(
        appBar: AppBar(
          title: Text(
              "Product Details",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20.0
            ),
          ),
        ),
        body:Container(
          width: MediaQuery.of(context).size.width,
          // decoration: BoxDecoration(border: Border.all(color: Colors.red,width: 2.0)),
          padding: EdgeInsets.all(10),
          child: designProvider.loading?
          Container(child:Image.asset("assets/images/placeholder.jpg",fit: BoxFit.fill,)):
          ListView(
            children: [
              //main image
              Container(

                      // decoration: BoxDecoration(border: Border.all(color: Colors.red,width: 2.0)),
                      child:_imageUrl.isEmpty?Image.network(
                          "$IMAGE_URL${designProvider.design.thumbnail}",fit: BoxFit.fill,
                      ):Image.network(
                        "$IMAGE_URL${_imageUrl}",fit: BoxFit.fill,
                      )
                  ),

              //small images
              Container(
                // decoration: BoxDecoration(border: Border.all(color: Colors.red,width: 2.0)),
                height: 100,
                
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ...imageList.map((e) => Container(
                        margin: EdgeInsets.all(5),
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              _imageUrl = e;
                            });
                          },
                          child: Image.network(
                            "$IMAGE_URL${e}",fit: BoxFit.fill,
                          )
                        )
                      )
                    )
                  ],
                ),
              ),

              //name and price
              Container(
                  // decoration: BoxDecoration(border: Border.all(color: Colors.greenAccent,width: 2.0)),
                  margin: EdgeInsets.only(top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          '${designProvider.design.name}',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight:FontWeight.w500,
                              color: Colors.black

                          )),
                      Text(
                        '$CURRENCY ${designProvider.design.price}',
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight:FontWeight.w900,
                            color: Colors.redAccent
                        ),
                      ),


                    ],
                  ),
              ),

              //fabric select
              Container(
                // decoration: BoxDecoration(border: Border.all(color: Colors.red,width: 2.0)),

                margin: EdgeInsets.only(top: 15),

                width: 50,
                child: MaterialButton(
                  elevation: 10.0,
                    onPressed: (){
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
                                 margin: EdgeInsets.only(left: 5,top: 10,bottom: 10),
                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     children:[
                                       Text('Available Fabrics',
                                           style: TextStyle(
                                               fontSize: 15,
                                               fontWeight: FontWeight.w600
                                           ),
                                       ),
                                       GestureDetector(
                                         onTap: () => Navigator.pop(context),
                                         child: Icon(
                                           Icons.close,
                                           color: Colors.red,
                                         ),
                                       )
                                     ]
                                 ),
                               ),

                              ...designProvider.design.fabrics.map((e) =>
                                Container(
                                  margin: EdgeInsets.only(left: 10,bottom: 5),
                                  child: Row(
                                    children: [
                                      Expanded(child: designProvider.loading?
                                      Image.asset("assets/images/placeholder.jpg",fit: BoxFit.fill,): Image.network(
                                        "$IMAGE_URL${e.thumbnail}",fit: BoxFit.fill,
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
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      fontWeight:FontWeight.w500,
                                                      color: Colors.black54

                                                  )),Text(
                                                  'Base color : ${e.baseColor}',
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      fontWeight:FontWeight.w500,
                                                      color: Colors.black54

                                                  )),

                                              Text(
                                                '$CURRENCY${e.pricePerYard} / Yard',
                                                style: TextStyle(
                                                    fontSize: 14.0,
                                                    fontWeight:FontWeight.w900,
                                                    color: Colors.black54
                                                ),
                                              ),

                                              OutlineButton(
                                                  onPressed: (){},
                                                child: Text('Select',style: TextStyle(fontSize: 15.0),),
                                              )

                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ),
                            ],
                          ),
                        );
                      }
                    );},
                  highlightElevation: 30.0,
                  splashColor: Colors.grey,
                  color: Colors.purple,
                  textColor: Colors.black,
                    child: Text(
                        'Choose Fabrics',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,

                      ),
                    ),
                ),
              ),

              //fabric size
              Container(
                // decoration: BoxDecoration(border: Border.all(color: Colors.red,width: 2.0)),

                margin: EdgeInsets.only(top: 10,left: 5,right: 5),
                child: Row(
                  children: [
                    Expanded(child: Text('Fabric Size:',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700),)),
                    Expanded(
                      child: Container(
                        height: 30,
                        child: TextField(

                          decoration: InputDecoration(
                            border: OutlineInputBorder(),

                          ),
                        ),
                      ),
                    ),
                    Expanded(child: Text('  yard',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700),)),
                  ],
                ),
              ),

              //add to cart
              Container(
                // decoration: BoxDecoration(border: Border.all(color: Colors.red,width: 2.0)),
                margin: EdgeInsets.only(top: 10,left: 5,right: 5),
                child: MaterialButton(
                  elevation: 10,
                  highlightElevation: 30.0,
                  splashColor: Colors.grey,
                  onPressed: (){},
                  color: Colors.black,
                  textColor: Colors.white,
                  child: Text(
                    'ADD TO CART',
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    )
                  ),
                ),
              ),

            ],
          ),

        )
    );
  }
}

