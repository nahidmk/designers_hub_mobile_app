import 'package:designers_hub_modile_app/widget/Drawer/create_drawer_body_item.dart';
import 'package:designers_hub_modile_app/widget/Drawer/create_drawer_header.dart';
import 'package:flutter/material.dart';

class SideDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          CreateDrawerHeader(),
          createDrawerBodyItem(
            icon: Icons.announcement,
            text: 'Terms and Condition',
            onTap: () {}

          ),
          Divider(),
          createDrawerBodyItem(
            icon: Icons.privacy_tip,
            text: 'Privacy policy',
            onTap: () {}
          ),
          Divider(),
          createDrawerBodyItem(
            icon: Icons.help,
            text: 'Help center',
            onTap: () {}
          ),

        ],
      ),
    );
  }


}

