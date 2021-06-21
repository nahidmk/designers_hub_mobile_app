import 'package:designers_hub_modile_app/Model/cart_details.dart';
import 'package:designers_hub_modile_app/Model/design.dart';
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

  @override
  void initState() {

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Provider.of<DesignProvider>(context, listen: false).getDesign(widget.cartDetails.design.id);
    });

  }



  String _fabricsName = "Choose Fabrics";
  double _quantityPrice = 0;
  var quantity = 0;

  @override
  Widget build(BuildContext context) {

    DesignProvider designProvider = Provider.of<DesignProvider>(context);
    Design _design = designProvider.design;
    double _designPrice = designProvider.design.price;
    String _fabricsName = "Choose Fabrics";
    double _quantityPrice = 0;
    var quantity = 0;
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
                                    // _fabric = e;
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

    return Container(

      child: Row(
        children: [
          Expanded(child: Image.network("$IMAGE_URL${widget.cartDetails.design.thumbnail}",fit: BoxFit.fill,)),
          Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Name : ${widget.cartDetails.design.name}"),
                    Container(
                      // decoration: BoxDecoration(border: Border.all(color: Colors.red,width: 2.0)),
                      height: 80,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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

                          Container(

                            width: 50,

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

                        ],
                      ),
                    ),
                  ],
                ),
              )
          )
        ],
      ),

    );
  }
}
