import 'widget/HomePage/Homepage.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Designer's Hub",
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: Homepage(),
    );
  }
}