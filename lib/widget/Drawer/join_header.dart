import 'package:designers_hub_modile_app/Screen/sign_in_screen.dart';
import 'package:designers_hub_modile_app/helper/text.dart';
import 'package:designers_hub_modile_app/widget/common/buttons.dart';
import 'package:flutter/material.dart';

class JoinHeader extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: EdgeInsets.only(left: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Text("Welcome to $APP_NAME",
                style: Theme.of(context).textTheme.headline2),
            SizedBox(height: 20,),
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: Image.asset(
              'assets/images/placeholder.jpg',
              fit: BoxFit.cover,
              )
            ),
            SizedBox(height: 20,),
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              height:40,
              child: FittedBox(
                child: secondaryButton((){Navigator.push(context, MaterialPageRoute(builder: (_)=>SignInScreen(false)));}, "JOIN", context)
              ),
            ),
          ],
        ),
      )
    );
  }
}
