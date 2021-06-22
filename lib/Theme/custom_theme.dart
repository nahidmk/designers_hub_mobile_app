import 'package:flutter/material.dart';

ThemeData CustomTheme(BuildContext context){

  Color primaryColor = Colors.black;


  TextTheme _textTheme(){
    return TextTheme(
      bodyText1: TextStyle(fontSize: 15,fontWeight: FontWeight.w300,color: Colors.black),
      bodyText2: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,color: primaryColor,),

      headline1: TextStyle(fontSize: 22,fontWeight: FontWeight.w300,color: Colors.black,),
      headline2: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: primaryColor),
      headline3: TextStyle(fontSize: 12,fontWeight: FontWeight.w300,color: Colors.black),
      headline4: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black),
      headline6: TextStyle(fontSize: 15,fontWeight: FontWeight.w300,color: primaryColor),

      button: TextStyle(fontSize: 15,fontWeight: FontWeight.w300),
      caption: TextStyle(fontSize: 15,fontWeight: FontWeight.w200,color: Colors.black,),
      subtitle1: TextStyle(fontSize: 12,fontWeight: FontWeight.w200,color: Colors.black)
    );
  }

  AppBarTheme _appBarTheme(){
    return AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.white,
      titleSpacing: 15,
      titleTextStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.black),
      centerTitle: false,
      brightness: Brightness.light,
      shadowColor: Colors.purpleAccent,
      foregroundColor: primaryColor,
      backwardsCompatibility: false
    );
  }

  final ThemeData base = ThemeData();
  return base.copyWith(
    primaryColor: primaryColor,
    textTheme: _textTheme(),
    backgroundColor: Colors.white30,
    appBarTheme: _appBarTheme(),
    shadowColor: Colors.grey,
    brightness: Brightness.light,
    accentColor: Colors.purpleAccent,
    highlightColor: Colors.blueGrey,


    hintColor: Colors.grey,

  );


}