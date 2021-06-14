import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              child: Image.asset(
                'assets/images/placeholder.png',
                height: 100,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              child: Column(
                children: [

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
