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



  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Provider.of<DesignProvider>(context, listen: false).getDesign(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {

    DesignProvider designProvider = Provider.of<DesignProvider>(context);


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
          // decoration: BoxDecoration(border: Border.all(color: Colors.red,width: 2.0)),
          padding: EdgeInsets.all(10),
          child: designProvider.loading?
          // Container(child:Image.asset("assets/images/placeholder.jpg",fit: BoxFit.fill,)):
          Center(child: CupertinoActivityIndicator(),):
          Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(

                          // decoration: BoxDecoration(border: Border.all(color: Colors.red,width: 2.0)),
                          child: Image.network(
                              "$IMAGE_URL${designProvider.design.thumbnail}",fit: BoxFit.fill,
                          )
                      ),
                   Container(
                      // decoration: BoxDecoration(border: Border.all(color: Colors.greenAccent,width: 2.0)),
                      margin: EdgeInsets.only(top: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'Name : ${designProvider.design.name}',
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight:FontWeight.w500,
                                  color: Colors.black54

                              )),Text(
                              'Description : ${designProvider.design.descriptions=='' ? 'No descriptions':designProvider.design.descriptions}',
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight:FontWeight.w500,
                                  color: Colors.black54

                              )),
                          Text(
                            'Price: $CURRENCY ${designProvider.design.price}',
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight:FontWeight.w900,
                                color: Colors.black54
                            ),
                          ),

                        ],
                      ),
                  )
                ],
              ),
            ),

        )
    );
  }
}

