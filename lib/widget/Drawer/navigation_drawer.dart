import 'package:designers_hub_modile_app/Provider/profile_provider.dart';
import 'package:designers_hub_modile_app/Screen/order_history_screen.dart';
import 'package:designers_hub_modile_app/widget/Drawer/drawer_header.dart';
import 'package:designers_hub_modile_app/widget/Drawer/join_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class NavigationDrawer extends StatefulWidget {



  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();

}

class _NavigationDrawerState extends State<NavigationDrawer> {




  @override
  Widget build(BuildContext context) {

    ProfileProvider profileProvider = Provider.of<ProfileProvider>(context);


    return profileProvider.isAuthenticated
        ? profileProvider.profileLoading
          ? CupertinoActivityIndicator(radius: 30,)
          :
            Container(
              // decoration: BoxDecoration(border: Border.all(color: Colors.lightGreenAccent,width: 2.0)),
              width: MediaQuery.of(context).size.width/1.3,
              child: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    createDrawerHeader(context,profileProvider.profile),
                    TermsAndCondition(),
                    OrderHistory(),
                    FacebookPage(),
                    Help(),
                    Divider(),
                    LogoutButton(),
                    PrivacyPolicy(),

                  ],
                ),
              ),
            )
    :JoinHeader();
  }
}



class LogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        Provider.of<ProfileProvider>(context, listen: false).signOut();
      },
      child: Row(
        children: <Widget>[
          Icon(CupertinoIcons.left_chevron, color: Colors.black54),
          SizedBox(width: 15),
          Text(
            'Sign out',
            style: CupertinoTheme.of(context).textTheme.textStyle,
          ),
        ],
      ),
    );
  }
}


class OrderHistory extends StatelessWidget {
@override
Widget build(BuildContext context) {
  return CupertinoButton(
    onPressed: () {
      Navigator.push(context, MaterialPageRoute(builder: (_)=>OrderHistoryScreen()));
    },
    child: Row(
      children: <Widget>[
        Icon(CupertinoIcons.time, color: Colors.black54),
        SizedBox(width: 15),
        Text(
          'Order History',
          style: CupertinoTheme.of(context).textTheme.textStyle,
        ),
      ],
    ),
  );
}
}

class TermsAndCondition extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        // _launchURL('https://oushodsheba.com/terms-and-conditions');
      },
      child: Row(
        children: <Widget>[
          Icon(CupertinoIcons.book, color: Colors.black54),
          SizedBox(width: 15),
          Text(
            'Terms and conditions',
            style: CupertinoTheme.of(context).textTheme.textStyle,
          ),
        ],
      ),
    );
  }
}


class FacebookPage extends StatelessWidget {

  _launchURL(String url) async {
    print('called');
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        _launchURL('https://www.facebook.com/profile.php?id=100073002721582');
      },
      child: Row(
        children: <Widget>[
          SvgPicture.asset('assets/icons/facebook_lite.svg', height: 20,color: Colors.black38,),

          SizedBox(width: 15),
          Text(
            'Facebook page',
            style: CupertinoTheme.of(context).textTheme.textStyle,
          ),
        ],
      ),
    );
  }
}


class Help extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        // _launchURL('https://oushodsheba.com/help');
      },
      child: Row(
        children: <Widget>[
          Icon(CupertinoIcons.info, color: Colors.black54),
          SizedBox(width: 15),
          Text(
            'Help',
            style: CupertinoTheme.of(context).textTheme.textStyle,
          ),
        ],
      ),
    );
  }
}


class PrivacyPolicy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        // _launchURL('https://oushodsheba.com/help');
      },
      child: Row(
        children: <Widget>[
          Icon(CupertinoIcons.map, color: Colors.black54),
          SizedBox(width: 15),
          Text(
            'Privacy policy',
            style: CupertinoTheme.of(context).textTheme.textStyle,
          ),
        ],
      ),
    );
  }
}