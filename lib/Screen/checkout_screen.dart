
import 'package:designers_hub_modile_app/Model/cart.dart';
import 'package:designers_hub_modile_app/Model/cart_details.dart';
import 'package:designers_hub_modile_app/Model/delivery_address.dart';
import 'package:designers_hub_modile_app/Model/promo.dart';
import 'package:designers_hub_modile_app/Provider/cart_design_provider.dart';
import 'package:designers_hub_modile_app/Provider/delivery_address_provider.dart';
import 'package:designers_hub_modile_app/Provider/design_provider.dart';
import 'package:designers_hub_modile_app/Screen/delvery_address_screen.dart';
import 'package:designers_hub_modile_app/widget/common/buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {

  List<CartDetails> cartDetailsList;


  CheckoutScreen(this.cartDetailsList);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Provider.of<CartDesignProvider>(context,listen: false).updateCart(widget.cartDetailsList);
    });

  }


  Cart cart = Cart(
      totalProducts: 0,
      printingCost: 0,
      totalPrice: 0,
      grandTotal: 0,
      finalPrice: 0,
      id: 0,
      discount: 0,
      cartDetailsList: [],
      promo: Promo(code: "")
  );
  bool _hasPromo = false;

  String promoCode = "";
  bool _loadingPromo = false;


  bool get loadingPromo => _loadingPromo;

  set loadingPromo(bool value) {
    setState(() {
      _loadingPromo = value;
    });
  }

  @override
  Widget build(BuildContext context) {

    DeliveryAddressProvider deliveryAddressProvider = Provider.of<DeliveryAddressProvider>(context);
    cart = Provider.of<CartDesignProvider>(context).cart;
    DeliveryAddress selectDeliveryAddress = deliveryAddressProvider.selectedDeliveryAddress;
    CartDesignProvider cartDesignProvider = Provider.of<CartDesignProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Check out"),),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              selectDeliveryAddress.title.isEmpty?
              Padding(
                padding: EdgeInsets.all(5),
                child: outlinedButton((){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>DeliveryAddressScreen()));
                }, "Choose Address", context),
              )
                  : Card(
                  child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(child: Text('Delivery Address',style: Theme.of(context).textTheme.headline1,)),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(selectDeliveryAddress.title,style: Theme.of(context).textTheme.headline4,),
                                  Text(selectDeliveryAddress.address,style: Theme.of(context).textTheme.headline6),
                                  Text(selectDeliveryAddress.phoneNumber,style: Theme.of(context).textTheme.headline6),
                                ],
                              ),
                              TextButton(onPressed:()=> Navigator.push(context, MaterialPageRoute(builder: (_)=>DeliveryAddressScreen()))
                                  , child: Text('Change',style: TextStyle(fontWeight: FontWeight.bold),))
                            ],

                          ),
                        ],
                      )
                  )
              ),
              SizedBox(
                height: 20,
              ),

              //promo
              !_hasPromo ?
              GestureDetector(
                  onTap: (){
                    setState(() {
                      _hasPromo = true;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Have a promo code ?',
                      style: TextStyle(color: CupertinoColors.activeBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
              ) :
              Card(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Promo Code',style: Theme.of(context).textTheme.headline1,),
                              TextButton(
                                  onPressed: (){
                                    setState(() {
                                      _hasPromo = false;
                                    });
                                  },
                                  child: Text('Hide', style: TextStyle(fontWeight: FontWeight.bold),)
                              )
                            ],
                          )
                      ),
                      Divider(),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 150,
                              height: 40,
                              child: cart.promo.code.isEmpty ? TextField(
                                keyboardType: TextInputType.text,
                                style: Theme.of(context).textTheme.headline4,
                                onChanged: (value){
                                  setState(() {
                                    promoCode = value;
                                  });
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              ) : Text(cart.promo.code, style: TextStyle(fontSize: 18),),
                            ),
                            loadingPromo ? CupertinoActivityIndicator() :
                            cart.promo.code.isEmpty ? secondaryButton(() async {
                              loadingPromo = true;
                              await cartDesignProvider.updateCart(cart.cartDetailsList, promoCode: promoCode);
                              loadingPromo = false;
                            }, "Apply", context) :
                            dangerButton(() async {
                              loadingPromo = true;
                              await cartDesignProvider.updateCart(cart.cartDetailsList, promoCode: '');
                              loadingPromo = false;
                            }, "Remove", context)
                          ],
                        ),
                      )
                    ],

                  ),
                ),
              ),

              //payment info
              Card(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(child: Text('Payment Information',style: Theme.of(context).textTheme.headline1,),),
                      Divider(),
                      PayMentInfo("Total Products", "${cart.totalProducts}"),
                      SizedBox(height: 10,),
                      PayMentInfo("Total Price", "${cart.totalPrice}"),
                      SizedBox(height: 10,),
                      PayMentInfo("Final price", "${cart.finalPrice}"),
                      SizedBox(height: 10,),
                      PayMentInfo("Discount", "${cart.discount}"),
                      Divider(),
                      PayMentInfo("Grand Total", "${cart.grandTotal}"),
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(5),
                child: cartDesignProvider.loadingOrder ?
                Center(child: CupertinoActivityIndicator(),) :
                secondaryButton(() async {
                  if(deliveryAddressProvider.selectedDeliveryAddress.title.isEmpty){
                    //show error msg in toast;
                    return;
                  }
                  cartDesignProvider.placeOrder(
                      deliveryAddressProvider.selectedDeliveryAddress);
                }, "Place Order", context),
              )

            ],

          ),
        ),
      ),
    );
  }
}

Widget PayMentInfo(String title, String price){

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(title),
      Text(price,),
    ],
  );
}