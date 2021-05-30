import 'package:flutter/material.dart';


class TopHotDesign extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    double screenHeight = ((MediaQuery.of(context).size.height)/4).roundToDouble();
    double screenWidth = (MediaQuery.of(context).size.width)/3.roundToDouble();
    return  Container(


      width: double.infinity,
      padding: EdgeInsets.all(5.0),
      child: Row(
        children: [
          Container(
            height: screenHeight,
            width: (screenWidth*2)-10,
            child: Card(
              elevation: 15.0,
              child: Text(
                  'width ${screenWidth*2-10} \n height $screenHeight',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Container(
            height: screenHeight,
            width: screenWidth,
            child: Card(
              elevation: 15.0,
              child: Text(
                'width $screenWidth \n height $screenHeight',
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }
}
