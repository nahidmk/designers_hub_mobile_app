
import 'package:designers_hub_modile_app/Screen/cart_screen.dart';
import 'package:designers_hub_modile_app/widget/HomePageDesign/HotDesignList.dart';
import 'package:designers_hub_modile_app/widget/common/custom_navigation_bar.dart';

import '../widget/Drawer/SideDrawer.dart';


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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Designer's Hub",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20.0
          ),
        )
      ),
      drawer: Drawer(
        elevation: 10.0,
        child: SideDrawer()
      ),

      body: Stack(
        children: [
          activeTab == 1 ? HotDesign() : CartScreen(),
          Positioned(
            bottom: 0,
            child: CustomNavigationBar(onChangeTab),
          )
        ],
      ),
    );
  }
}
