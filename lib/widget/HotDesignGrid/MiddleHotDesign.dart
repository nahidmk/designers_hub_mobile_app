import 'dart:ui';

import 'package:designers_hub_modile_app/Provider/home_page_design_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MiddleHotDesign extends StatefulWidget {

  @override
  _MiddleHotDesignState createState() => _MiddleHotDesignState();
}

class _MiddleHotDesignState extends State<MiddleHotDesign> {

  @override

  @override
  Widget build(BuildContext context) {
    double screenHeight = ((MediaQuery.of(context).size.height)/4).roundToDouble();
    double screenWidth = (MediaQuery.of(context).size.width);

    return Container(
      padding: EdgeInsets.all(5.0),
      width: screenWidth,
      height: screenHeight,

      child: Card(
        elevation: 5.0,
        child: Image.asset(
                  'assets/images/middle.jpg',
                   fit: BoxFit.cover,
              ),
      ),
    );
  }
}
