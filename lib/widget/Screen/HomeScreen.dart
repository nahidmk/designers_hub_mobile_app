
import '../HotDesignGrid/MiddleHotDesign.dart';
import '../Drawer/SideDrawer.dart';

import '../DesignList/DesignCardList.dart';
import '../HotDesignGrid/TopHotDesign.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {



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

      body: SingleChildScrollView(
        child: Column(

          children: [

           TopHotDesign(),

            MiddleHotDesign(),

            DesignList(),

          ],
        ),
      ),
    );
  }
}
