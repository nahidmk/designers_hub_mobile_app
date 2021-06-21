
import 'package:designers_hub_modile_app/Screen/profile_screen.dart';
import 'package:designers_hub_modile_app/Screen/cart_screen.dart';
import 'package:designers_hub_modile_app/widget/Drawer/navigation_drawer.dart';
import 'package:designers_hub_modile_app/widget/HomePageDesign/HotDesignList.dart';
import 'package:designers_hub_modile_app/widget/common/custom_navigation_bar.dart';




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
      return ProfileScreen(backToHome: backToHome,);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Designer's Hub",

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
    );
  }
}
