import 'package:designers_hub_modile_app/Provider/order_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomNavigationBar extends StatefulWidget {

  final Function onClick;


  CustomNavigationBar(this.onClick);

  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {



  int activeTab = 1;

  void _onClick(tab) {
    setState(() {
      activeTab = tab;
    });
    widget.onClick(tab);
  }

  Color _getColor(tab){
    return activeTab == tab ? Colors.redAccent : Colors.black54;
  }

  TextStyle _getStyle(tab){
    return TextStyle(
        fontSize: 12,
        color: _getColor(tab)
    );
  }



  @override
  Widget build(BuildContext context) {

    OrderProvider orderProvider = Provider.of<OrderProvider>(context,listen: false);

    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow:[BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            )],
          ),
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: (){
                  _onClick(1);
                },
                child: Column(
                  children: [
                    Icon(CupertinoIcons.home, color: _getColor(1),),
                    Text('Home', style: _getStyle(1),)
                  ],
                ),
              ),

              GestureDetector(
                onTap: (){
                  _onClick(2);
                },
                child: Column(
                  children: [
                    Icon(CupertinoIcons.cart, color: _getColor(2),),
                    Text('Cart', style: _getStyle(2),)
                  ],
                ),
              ),

              GestureDetector(
                onTap: (){
                  _onClick(3);
                },
                child: Column(
                  children: [
                    Icon(CupertinoIcons.person, color: _getColor(3),),
                    Text('Account', style: _getStyle(3),)
                  ],
                ),
              )
            ],
          ),
        ),
        orderProvider.cart.cartDetailsList.length>=1?
        Positioned(
            bottom: 27,
            right: (MediaQuery.of(context).size.width/2)-22,
            child: Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
              child: Center( child: Text("${orderProvider.cart.cartDetailsList.length}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
            )
        ):SizedBox(width: 0,),
      ],
    );
  }
}
