
import 'package:designers_hub_modile_app/Screen/profile_screen.dart';
import 'package:designers_hub_modile_app/Screen/cart_screen.dart';
import 'package:designers_hub_modile_app/helper/text.dart';
import 'package:designers_hub_modile_app/widget/Drawer/navigation_drawer.dart';
import 'package:designers_hub_modile_app/widget/HomePageDesign/HotDesignList.dart';
import 'package:designers_hub_modile_app/widget/common/custom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';




import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int activeTab = 1;

  void onChangeTab(tab){
    setState(() {
      activeTab = tab;
    });
  }

  void backToHome(){
    setState(() {
      activeTab=1;
    });
  }
  
  Widget activeScreen(value){
    if(value==1){
      return HotDesign();
    }else if(value==2){
      return CartScreen(fromProductDetails: false,);
    }else{
      return ProfileScreen();
    }
  }



  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: Text('Warning?',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
        content: Text('Do you want to exit an App',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15)),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
              title: Text(
                APP_NAME,
              )
          ),
          drawer:  NavigationDrawer(),
          body: Stack(
            children: [
              activeScreen(activeTab),
              Positioned(
                bottom: 0,
                child: CustomNavigationBar(onChangeTab),
              )
            ],
          ),
        ),
        onWillPop: _onWillPop
    );
  }
}
