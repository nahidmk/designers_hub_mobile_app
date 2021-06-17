import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:os_ios/helper/colors.dart';
import 'package:os_ios/helper/constants.dart';
import 'package:os_ios/helper/functions.dart';
import 'package:os_ios/models/user.dart';

class ProfileHeader extends StatelessWidget {
  final User user;

  const ProfileHeader({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SafeArea(
          child: ClipPath(
            clipper: new MyClipper(),
            child: Container(
              padding: EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height / 4 + 30,
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
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: GRADIENT_RED,
                ),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        capitalize(user.name.fullName),
                        style: TextStyle(
                            color: CupertinoColors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      if(user.primaryPhone != null && user.primaryPhone.isNotEmpty)
                      Text(
                        '${user.primaryPhone}',
                        style: TextStyle(
                            color: Color(0xFFeeeeee),
                            fontWeight: FontWeight.w300,
                            fontSize: 12),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Balance: ${user.balance}',
                        style: TextStyle(
                            color: Color(0xFFeeeeee),
                            fontWeight: FontWeight.w300,
                            fontSize: 12),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),

        Positioned(
          top: 40,
          right: 10,
          child: ClipRRect(
            child: Container(
              color: CupertinoColors.white,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Image.asset(
                  'assets/images/os_logo.png',
                  fit: BoxFit.cover,
                  height: 25,
                  width: 25,
                ),
              ),
            ),
            borderRadius: BorderRadius.circular(60.0),
          ),
        ),
        Positioned(
          bottom: 20,
          right: 50,
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
                      '$IMAGE_API_URL${user.profilePicture}',
                      fit: BoxFit.cover,
                      height: 90,
                      width: 90,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes
                          : null,
                    ),
                  );
                },
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
    path.lineTo(0, size.height - 40);
    path.lineTo(20, size.height - 15);

    path.quadraticBezierTo(32, size.height, 60, size.height - 8);

    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
