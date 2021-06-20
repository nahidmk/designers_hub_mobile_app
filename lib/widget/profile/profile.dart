
import 'package:designers_hub_modile_app/Model/user.dart';
import 'package:designers_hub_modile_app/Provider/profile_provider.dart';
import 'package:designers_hub_modile_app/widget/profile/profile_header.dart';
import 'package:designers_hub_modile_app/widget/profile/profile_informations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {


  @override
  Widget build(BuildContext context) {

    ProfileProvider profileProvider = Provider.of<ProfileProvider>(context);
    return Container(
      child: profileProvider.profileLoading ?
      CupertinoActivityIndicator() :
      profileProvider.profileErrorMsg != '' ?
      Center(child: Text(profileProvider.profileErrorMsg),) :
      // Center(child: Text('hello world')),
      Container(height: MediaQuery.of(context).size.height, width:MediaQuery.of(context).size.width,child: ProfileView(user: profileProvider.profile,)),
    );
  }
}


class ProfileView extends StatelessWidget {
  User user;

  ProfileView({ required this.user});



  @override
  Widget build(BuildContext context) {

    final bottomPadding = MediaQuery.of(context).size.height >= 812 ? 34 : 0;

    print("user email---->${user.email}");
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height - 50 - bottomPadding,
        child: Column(children: <Widget>[
          ProfileHeader(user: user),
          // Expanded(child: Text('hello'))
          Expanded(child: ProfileInformation(user: user))
        ]),
      ),
    );
  }
}

