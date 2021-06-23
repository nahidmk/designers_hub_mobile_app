import 'package:designers_hub_modile_app/Model/delivery_address.dart';
import 'package:designers_hub_modile_app/Provider/delivery_address_provider.dart';
import 'package:designers_hub_modile_app/Screen/add_address_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Address extends StatelessWidget {
  final DeliveryAddress address;

  Address({required this.address});

  @override
  Widget build(BuildContext context) {
    DeliveryAddressProvider deliveryAddressProvider =
        Provider.of<DeliveryAddressProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () async {
          deliveryAddressProvider.selectedDeliveryAddress = address;
            Navigator.pop(context);
        },
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 10, top: 20, bottom: 20),
          decoration: BoxDecoration(
            color: CupertinoColors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: CupertinoColors.inactiveGray.withOpacity(0.5),
                spreadRadius: -7,
                blurRadius: 15,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            children: <Widget>[
              Icon(deliveryAddressProvider.selectedDeliveryAddress != null && deliveryAddressProvider.selectedDeliveryAddress.id == address.id
                  ? CupertinoIcons.location_solid
                  : CupertinoIcons.location),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    address.title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                      width:
                      MediaQuery.of(context).size.width - 40 - 40 - 20 - 34,
                      child: Text(
                        "Address: ${address.address}",
                        style: Theme.of(context).textTheme.headline6,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      )
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Phone : ${address.phoneNumber}",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
              SizedBox(
                width: 40,
                child: FittedBox(
                  child: CupertinoButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext ctx) => CupertinoActionSheet(
                          title: const Text('Choose Options'),
                          actions: <Widget>[
                            CupertinoActionSheetAction(
                              child: const Text('Edit address'),
                              onPressed: () {
                                Navigator.pop(ctx, 'Edit');
                                Navigator.push(context, MaterialPageRoute(builder: (_)=>AddAddressScreen(args: address,)));
                                // Navigator.pushNamed(context, AddAddressScreen.routeName, arguments: address);

                              },
                            ),
                            deliveryAddressProvider.loadingDeleteAddress
                                ? Center(
                                    child: CupertinoActivityIndicator(
                                      radius: 15,
                                    ),
                                  )
                                : CupertinoActionSheetAction(
                                    child: const Text(
                                      'Delete address',
                                      style: TextStyle(
                                          color: CupertinoColors.systemRed),
                                    ),
                                    onPressed: () async {
                                      bool status = await deliveryAddressProvider
                                          .deleteDeliveryAddress(address);
                                      if (status) Navigator.pop(ctx, 'delete');
                                    },
                                  )
                          ],
                        ),
                      );
                    },
                    child: Icon(CupertinoIcons.info,color: Colors.black,),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
