
import 'package:designers_hub_modile_app/Screen/sign_in_screen.dart';
import 'package:designers_hub_modile_app/helper/text.dart';
import 'package:designers_hub_modile_app/widget/common/buttons.dart';
import 'package:flutter/material.dart';

class CreateDrawerHeader extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(

            image: DecorationImage(
                fit: BoxFit.fill,
                image:  AssetImage('assets/images/placeholder.jpg')
            )
        ),
        child: Stack(children: <Widget>[
          Positioned(
              bottom: 70.0,
              left: 16.0,
              child: secondaryButton((){
                Navigator.push(context, MaterialPageRoute(builder: (_)=>SignIn()));
              }, "Join", context)
            // child: MaterialButton(
            //   onPressed: (){
            //     Navigator.push(context, MaterialPageRoute(builder: (_)=>SignIn()));
            //   },
            //   child: Text('JOIN'),
            // ),
          ),
          Positioned(
              bottom: 12.0,
              left: 16.0,
              child: Text("Welcome to $APP_NAME",
                  style: Theme.of(context).textTheme.headline2)),
        ]));
  }
}
