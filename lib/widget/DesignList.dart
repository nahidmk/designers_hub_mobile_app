import 'package:flutter/material.dart';

class DesignList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0),
      height: (MediaQuery.of(context).size.height)/4,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Container(
            width: 100.0,
            child: Card(
              elevation: 15.0,
              child: Text(
                  'Card 1',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Container(
            width: 100.0,
            child: Card(
              elevation: 15.0,
              child: Text(
                  'Card 2',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Container(
            width: 100.0,
            child: Card(
              child: Text(
                  'Card 3',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Container(
            width: 100.0,
            child: Card(
              elevation: 15.0,
              child: Text(
                  'Card 4',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Container(
            width: 100.0,
            child: Card(
              elevation: 15.0,
              child: Text(
                  'Card 5',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
