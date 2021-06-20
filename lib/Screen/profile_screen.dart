import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:designers_hub_modile_app/Provider/profile_provider.dart';
import 'package:designers_hub_modile_app/Screen/sign_in_screen.dart';
import 'package:designers_hub_modile_app/widget/HomePageDesign/HotDesignList.dart';
import 'package:designers_hub_modile_app/widget/profile/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ProfileScreen extends StatefulWidget {

  Function backToHome;

  ProfileScreen({required this.backToHome});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {


  void initState() {
    // TODO: implement initState
    super.initState();
    print('Profile init state called.');
    BackButtonInterceptor.add(myInterceptor);
  }

  bool myInterceptor(bool stopDefaultButtonEvent,RouteInfo routeInfo) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    } else {
      if (widget.backToHome != null) {
        widget.backToHome();
      }
    }
    return true;
  }


  @override
  Widget build(BuildContext context) {
    ProfileProvider profileProvider = Provider.of<ProfileProvider>(context);

    return profileProvider.isAuthenticated ?
        CupertinoPageScaffold(backgroundColor: CupertinoColors.white, child: Profile())
        : SignInScreen(true);

    // return Container(
    //  decoration: BoxDecoration(border: Border.all(color: Colors.red,width: 2.0)),
    //   child: Center(
    //     child: Text('account'),
    //   ),
    // );
  }
}

