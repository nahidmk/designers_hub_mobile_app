import 'dart:ui';

import 'package:flutter/material.dart';

class MiddleHotDesign extends StatelessWidget {

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
