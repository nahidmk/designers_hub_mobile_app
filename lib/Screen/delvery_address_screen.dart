
import 'package:designers_hub_modile_app/Provider/profile_provider.dart';
import 'package:designers_hub_modile_app/Screen/sign_in_screen.dart';
import 'package:designers_hub_modile_app/widget/delivery_address/delivery_address_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeliveryAddressScreen extends StatefulWidget {

  @override
  _DeliveryAddressScreenState createState() => _DeliveryAddressScreenState();
}

class _DeliveryAddressScreenState extends State<DeliveryAddressScreen> {
  @override
  Widget build(BuildContext context) {
    ProfileProvider profileProvider = Provider.of<ProfileProvider>(context);
    return profileProvider.isAuthenticated ?
    Scaffold(
      appBar: AppBar(title: Text('Choose delivery address',)),
      body: DeliveryAddressList(),
    ):
    SignInScreen(false);

  }
}
