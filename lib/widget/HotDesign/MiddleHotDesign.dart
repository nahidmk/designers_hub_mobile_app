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
        elevation: 15.0,
        child: Text(
          'width $screenWidth \n height $screenHeight',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
