import 'package:designers_hub_modile_app/helper/currency.dart';
import 'package:flutter/cupertino.dart';
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
        margin: EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(5),
              bottomRight: Radius.circular(5)
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Image.network(imgUrl,fit: BoxFit.cover,),
            ),
            Expanded(
                child: Container(
                  // decoration: BoxDecoration(border: Border.all(color: Colors.red,width: 2)),
                  // width:( MediaQuery.of(context).size.width/3.2)*2,
                  padding: EdgeInsets.only(left: 20, top: 5, bottom: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$name',
                        style:TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54
                        ),
                      ),
                      SizedBox(height: 3,),
                      Text(
                        '$CURRENCY $price',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                ),
            )

          ],
        )

    );
  }
}
