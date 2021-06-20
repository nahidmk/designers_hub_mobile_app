import 'package:designers_hub_modile_app/Model/user.dart';
import 'package:designers_hub_modile_app/helper/functions.dart';
import 'package:designers_hub_modile_app/helper/text.dart';
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

              image: DecorationImage(

                  fit: BoxFit.fill,
                  image:  AssetImage('assets/images/placeholder.jpg'))),
          child: Stack(children: <Widget>[
            Positioned(
              bottom: 50.0,
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
                    child: Text("Name : ${capitalize(user.fullName)}",style: Theme.of(context).textTheme.headline4,),
                  ),
                  Container(
                    child: Text("Phone : ${user.primaryNumber}",style: Theme.of(context).textTheme.headline4,),
                  )
                ],
              ) ,
            )
          ]
          )

    ),
  );
}