import 'package:designers_hub_modile_app/Model/user.dart';
import 'package:designers_hub_modile_app/helper/functions.dart';
import 'package:designers_hub_modile_app/helper/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

Widget createDrawerHeader(BuildContext context,User user) {
  return Container(
    height: 200,
    child: DrawerHeader(

          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
            color: Colors.black,
          ),
          child: Stack(children: <Widget>[
            Positioned(
              bottom: 40.0,
              left: 16.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: SvgPicture.asset('assets/icons/person.svg',
                        fit: BoxFit.cover, height: 60, width: 60),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15,top: 5),
                    child: Text("${capitalize(user.fullName)}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.white),),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15,),
                    child: Text("${user.primaryNumber}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.white),),
                  )
                ],
              ) ,
            )
          ]
          )

    ),
  );
}