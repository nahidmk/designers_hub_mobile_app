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
        elevation: 5.0,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: cardWidth,
              height: (cardHeight/3)*2-15,
              child: Image.network(imgUrl,fit: BoxFit.fill,),

            ),
            Container(
              padding: EdgeInsets.all(10),
              width: cardWidth,
              height: (((cardHeight/3)/3)*2)+5,
              child: Text(
                '$name',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight:FontWeight.w600
                ),
              ),
            ),
            Container(
              // margin: EdgeInsets.only(left: 5),
              width: cardWidth,
              height: ((cardHeight/3)/3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                    Text(
                    ' \$$price',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight:FontWeight.w900
                      ),
                    ),
                  Container(
                    padding: EdgeInsets.all(5),
                    child: FloatingActionButton(
                        onPressed: (){},
                      child: Icon(
                        Icons.add_shopping_cart_rounded,
                        color: Colors.black,
                        size: 25,
                      ),
                    ),
                  )
                ],
                ),
              ),
          ],
        )
      ),
    );
  }
}
