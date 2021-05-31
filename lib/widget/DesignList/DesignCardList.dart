import 'package:designers_hub_modile_app/widget/DesignList/SingleDesignCard.dart';
import 'package:flutter/material.dart';

class DesignList extends StatelessWidget {

  

  @override
  Widget build(BuildContext context) {
    double screenHeight = ((MediaQuery.of(context).size.height)/4)+40;
    double screenWidth = (MediaQuery.of(context).size.width)/3;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0),
      height: screenHeight,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          SingleDesignCard(2103, "Sunflowers and cream 7x7", screenWidth, screenHeight, "assets/images/1.jpg"),
          SingleDesignCard(550, "Navy Stripe Poppy", screenWidth, screenHeight, "assets/images/2.jpg"),
          SingleDesignCard(1500, "C", screenWidth, screenHeight, "assets/images/3.jpg"),
          SingleDesignCard(1800, "Forest Animal Hot Air ftghdf ghggdhjhdgy 6jy5u5k gj6 iu k Balloon Forest Animal Hot Air ftghdfghggdhjhdgy 6jy5u5k gj6 iu k Balloon Forest Animal Hot Air ftghdfghggdhjhdgy 6jy5u5k gj6 iu k Balloon", screenWidth, screenHeight, "assets/images/4.jpg"),
          SingleDesignCard(2180, "Stained Glass Rose Windows", screenWidth, screenHeight, "assets/images/5.png"),

        ],
      ),
    );
  }
}
