import 'package:designers_hub_modile_app/helper/currency.dart';
import 'package:flutter/material.dart';

class SingleDesignCard extends StatelessWidget {

  final double price;
  final String name;
  final double cardWidth;
  final double cardHeight;
  final String imgUrl;
  final String description;

  SingleDesignCard(this.price, this.name,this.cardWidth,this.cardHeight,this.imgUrl,this.description);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: cardWidth,
      child: Card(
        elevation: 5.0,
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
                      style: TextStyle(
                          fontSize: 12.0,
                          fontWeight:FontWeight.w500,
                          color: Colors.black54

                      )),Text(
                        'Description : ${description=='' ? 'No descriptions':description}',
                        style: TextStyle(
                            fontSize: 12.0,
                            fontWeight:FontWeight.w500,
                            color: Colors.black54

                        )),
                      Text(
                      ' $CURRENCY $price',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight:FontWeight.w900,
                          color: Colors.black54
                        ),
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
