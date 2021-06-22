
import 'package:designers_hub_modile_app/Model/delivery_address.dart';
import 'package:designers_hub_modile_app/Provider/delivery_address_provider.dart';
import 'package:designers_hub_modile_app/widget/delivery_address/address.dart';
import 'package:designers_hub_modile_app/widget/error/show_error.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeliveryAddressList extends StatefulWidget {


  @override
  _DeliveryAddressListState createState() => _DeliveryAddressListState();
}

class _DeliveryAddressListState extends State<DeliveryAddressList> {
  List<DeliveryAddress> deliveryAddresses=[];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_){
      getDeliveryAddresses();
    });

  }

  getDeliveryAddresses() async {
    Provider.of<DeliveryAddressProvider>(context, listen: false)
        .getAllDeliveryAddresses();
  }

  @override
  Widget build(BuildContext context) {

    DeliveryAddressProvider deliveryAddressProvider = Provider.of<DeliveryAddressProvider>(context);
    return deliveryAddressProvider.deliveryAddressesErrorMsg != '' ? ShowError(errorMsg: deliveryAddressProvider.deliveryAddressesErrorMsg,onReload: getDeliveryAddresses,)
         : Container(
        child: deliveryAddressProvider.loadingDeliveryAddresses
            ? Center(
            child: CupertinoActivityIndicator(
              radius: 15,
            ))
            : DeliveryAddressListView( deliveryAddresses: deliveryAddressProvider.deliveryAddresses)
    );
  }
}



class DeliveryAddressListView extends StatelessWidget {
  final deliveryAddresses;


  DeliveryAddressListView({required this.deliveryAddresses});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        child: ListView(
          children: [
            ...deliveryAddresses
                .map((e) => Address(
              address: e,
            ))
                .toList(),

          ],
        ),
      ),
      Positioned(
        bottom: 5,
        right: 5,
        child: Container(
          child: FloatingActionButton(
            onPressed: (){
              print('add address');
              },
            child: const Icon(Icons.add),
          ),
        )
      )

    ]);
  }
}

