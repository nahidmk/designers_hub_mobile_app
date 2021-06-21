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
      child: Card(
        elevation: 2,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image.network(imgUrl,fit: BoxFit.fill,),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 10, top: 5, bottom: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      Text(
                      'Name : $name',
                      style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Text(
                      ' $CURRENCY $price',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                  ],
                  ),
                ),
            ),
          ],
        )
      ),
    );
  }
}
