import 'package:designers_hub_modile_app/helper/currency.dart';
import 'package:flutter/material.dart';

class SingleDesignCard extends StatelessWidget {

  final double price;
  final String name;
  final double cardWidth;
  final double cardHeight;
  final String imgUrl;

  SingleDesignCard(this.price, this.name,this.cardWidth,this.cardHeight,this.imgUrl);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: cardWidth,
      height: MediaQuery.of(context).size.height/5,
      child: Card(
        elevation: 2,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Image.network(imgUrl,fit: BoxFit.fill,),
            ),
            Container(
              // decoration: BoxDecoration(border: Border.all(color: Colors.red,width: 2)),
                width:( MediaQuery.of(context).size.width/3.2)*2,
                padding: EdgeInsets.only(left: 10, top: 5, bottom: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                       Text(
                          'Name : $name',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      SizedBox(height: 8,),
                      Text(
                      '$CURRENCY $price',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                  ],
                  ),
                ),

          ],
        )
      ),
    );
  }
}
