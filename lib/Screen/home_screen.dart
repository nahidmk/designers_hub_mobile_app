
import 'package:designers_hub_modile_app/widget/HotDesignGrid/HotDesignList.dart';

import '../widget/DesignList/design_card_list.dart';
import '../widget/HotDesignGrid/MiddleHotDesign.dart';
import '../widget/HotDesignGrid/TopHotDesign.dart';
import '../widget/Drawer/SideDrawer.dart';


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

      body: HotDesign(),
    );
  }
}
