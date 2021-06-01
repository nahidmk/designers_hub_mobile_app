import 'package:flutter/material.dart';


class TopHotDesign extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    double screenHeight = ((MediaQuery.of(context).size.height)/4).roundToDouble();
    double screenWidth = (MediaQuery.of(context).size.width)/3.roundToDouble();
    return  Container(
      width: screenWidth*3,
      height: screenHeight,
      padding: EdgeInsets.all(5.0),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children:[
          Row(
          children: [
            Container(
              height: screenHeight,
              width: (screenWidth*2)-10,
              child: Card(
                elevation: 5.0,
                child: Image.asset("assets/images/top_left.jpg",fit: BoxFit.fill,)
              ),
            ),
            Container(
              height: screenHeight,
              width: screenWidth,
              child: Card(
                elevation: 5.0,
                child: Image.asset("assets/images/top_right.jpg",fit: BoxFit.fill,)
              ),
            ),
            Container(
              height: screenHeight,
              width: (screenWidth*2)-10,
              child: Card(
                  elevation: 5.0,
                  child: Image.asset("assets/images/top_left.jpg",fit: BoxFit.fill,)
              ),
            ),
            Container(
              height: screenHeight,
              width: screenWidth,
              child: Card(
                  elevation: 5.0,
                  child: Image.asset("assets/images/top_right.jpg",fit: BoxFit.fill,)
              ),
            )
          ],
        )
            ],
        ),

    );
  }
}
