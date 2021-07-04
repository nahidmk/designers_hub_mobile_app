import 'package:designers_hub_modile_app/Screen/home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Future.delayed(Duration(milliseconds: 1500)).then((value) =>
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>HomeScreen())));
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 150.0,
          width: 150.0,
          child: Image.asset("assets/images/1.jpg"),
        ),
      ),
    );
  }
}
