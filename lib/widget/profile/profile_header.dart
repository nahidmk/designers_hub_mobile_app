import 'package:designers_hub_modile_app/Model/user.dart';
import 'package:designers_hub_modile_app/helper/colors.dart';
import 'package:designers_hub_modile_app/helper/constants.dart';
import 'package:designers_hub_modile_app/helper/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileHeader extends StatelessWidget {
  final User user;

  ProfileHeader({required this.user});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SafeArea(
          child: ClipPath(
            clipper: new MyClipper(),
            child: Container(
              padding: EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height / 5 ,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: CupertinoColors.black.withOpacity(0.5),
                    spreadRadius: -1,
                    blurRadius: 15,
                    offset: Offset(0, 2), // changes position of shadow
                  ),
                ],
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.blue, Colors.green,],
                ),

              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        capitalize(user.fullName),
                        style: TextStyle(
                            color: CupertinoColors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      if(user.primaryNumber != null && user.primaryNumber.isNotEmpty)
                      Text(
                        '${user.primaryNumber}',
                        style: TextStyle(
                            color: Color(0xFFeeeeee),
                            fontWeight: FontWeight.w300,
                            fontSize: 12),
                      ),
                      SizedBox(
                        height: 5,
                      ),

                    ],
                  )
                ],
              ),
            ),
          ),
        ),


        Positioned(
          bottom: 20,
          right: 100,
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(60),
              boxShadow: [
                BoxShadow(
                  color: CupertinoColors.inactiveGray.withOpacity(0.5),
                  spreadRadius: -2,
                  blurRadius: 15,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            child: ClipRRect(
              child: user.profilePicture == null
                  ? SvgPicture.asset(
                      'assets/icons/person.svg',
                      fit: BoxFit.cover,
                      height: 90,
                      width: 90,
                    )
                  : Image.network(
                      '$IMAGE_URL${user.profilePicture}',
                      fit: BoxFit.cover,
                      height: 90,
                      width: 90,
                errorBuilder: (context, error, stackTrace) {
                  return SvgPicture.asset(
                    'assets/icons/person.svg',
                    fit: BoxFit.cover,
                    height: 90,
                    width: 90,
                  );
                },
                    ),
              borderRadius: BorderRadius.circular(60.0),
            ),
          ),
        )
      ],
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    // path.moveTo(0, size.height/2);
    path.lineTo(0,0);
    path.lineTo(0,size.height);

    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    //
    //  path.quadraticBezierTo(32, size.height, 60, size.height - 8);
    //


    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
