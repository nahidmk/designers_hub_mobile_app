import 'package:designers_hub_modile_app/Model/delivery_address.dart';
import 'package:designers_hub_modile_app/Model/widget_helper_models/textFieldProperties.dart';
import 'package:designers_hub_modile_app/Provider/delivery_address_provider.dart';
import 'package:designers_hub_modile_app/widget/common/buttons.dart';
import 'package:designers_hub_modile_app/widget/common/form_attribute.dart';
import 'package:designers_hub_modile_app/widget/signin_signup_form/helper_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:provider/provider.dart';

class AddAddressScreen extends StatefulWidget {

  DeliveryAddress args;

  AddAddressScreen({required this.args});

  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {



  TextFieldProperties _titleProperties = new TextFieldProperties(

      controller: new TextEditingController(),
      inputType: "text",
      keyboardType: TextInputType.text,
      label: 'Title  (Home / Office / Other)',
      validate: (String text) {
        if (text.length < 3) {
          return 'Too small';
        } else if (text.length > 20) {
          return 'Too long';
        } else
          return '';
      });

  TextFieldProperties _addressProperties = new TextFieldProperties(
      inputType: "text",
      keyboardType: TextInputType.text,
      controller: new TextEditingController(),
      label: 'Address',
      maxLine: 3,
      validate: (String text) {
        if (text.length < 3) {
          return 'Too small';
        } else if (text.length > 100) {
          return 'Too long';
        } else
          return '';
      });

  TextFieldProperties _phoneNumberProperties = new TextFieldProperties(
      controller: new TextEditingController(),
      label: "Phone Number",

      keyboardType: TextInputType.number,
    inputType: "text",
      validate: (String text) {
        if (text.length < 11 || text.length > 11) {
          return 'Phone number must be 11 digits.';
        } else
          return '';
      }
  );



  String _errorMessage = '';

  _dismissErrorMsg() {
    setState(() {
      _errorMessage = '';
    });

    Provider.of<DeliveryAddressProvider>(context, listen: false)
        .deliveryAddressesErrorMsg = '';
  }

  _onChange() {}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_){
      Provider.of<DeliveryAddressProvider>(context, listen: false)
          .addAddressErrorMsg = '';

      print('args.....>${widget.args.title}');
      if (widget.args != null) {
        _titleProperties.controller.text = widget.args.title;
        _addressProperties.controller.text = widget.args.address;
        _phoneNumberProperties.controller.text = widget.args.phoneNumber;

      }
    });

  }

//  @ove


  _checkFormValidity() {
    bool valid = true;
    [_addressProperties, _titleProperties,_phoneNumberProperties].forEach((element) {
      if (element.controller.text.isEmpty) {
        setState(() {
          _errorMessage = 'Please fill all the fields';
        });
        valid = false;
        return;
      } else if (element.validate(element.controller.text).length > 0) {
        setState(() {
          _errorMessage = 'Please validate the form.';
        });
        valid = false;
        return;
      }
    });


    return valid;
  }

  _submitAddress(BuildContext context) async {
    if (_checkFormValidity()) {
      bool status = true;
      DeliveryAddress deliveryAddress = new DeliveryAddress(
          id: 0,
          title: _titleProperties.controller.text,
          address: _addressProperties.controller.text,
          phoneNumber: _phoneNumberProperties.controller.text,
      );
      if (widget.args.title.isEmpty)
        status =
            await Provider.of<DeliveryAddressProvider>(context, listen: false)
                .createDeliveryAddress(deliveryAddress);
      else {
        deliveryAddress.id = widget.args.id;
        status =
            await Provider.of<DeliveryAddressProvider>(context, listen: false)
                .updateDeliveryAddress(deliveryAddress);
      }

      if (status) Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    DeliveryAddressProvider deliveryAddressProvider =
        Provider.of<DeliveryAddressProvider>(context);

    return  Scaffold(
      appBar: AppBar(title: Text(widget.args.title.isEmpty ? 'Add Address' : 'Edit address',),),
                body: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          height:
                              MediaQuery.of(context).size.height - 40 - 58 - 16,
                          child: ListView(
                            children: <Widget>[
                              FormAttribute(
                                icon:
                                    _buildSvgPicture('assets/icons/title.svg'),
                                properties: _titleProperties,
                                onChange: _onChange,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              FormAttribute(
                                icon: Icon(CupertinoIcons.home),
                                properties: _addressProperties,
                                onChange: _onChange,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              FormAttribute(
                                  icon: Icon(CupertinoIcons.phone),
                                  properties: _phoneNumberProperties,
                                  onChange: _onChange,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              ShowErrorMsgIfNeeded(
                                  _errorMessage.length > 0
                                      ? _errorMessage
                                      : deliveryAddressProvider
                                          .addAddressErrorMsg,
                                  _dismissErrorMsg),
                              deliveryAddressProvider.loadingAddAddress
                                  ? CupertinoActivityIndicator()
                                  :
                              MaterialButton(
                                onPressed: (){
                                  _submitAddress(context);
                                },
                                child: Text(
                                    widget.args.title.isEmpty ? 'Add address' : 'Edit address',
                                  style: Theme.of(context).textTheme.button,
                                ),
                                color: Colors.black,
                                splashColor: Colors.greenAccent,
                                highlightElevation: 30.0,
                                textColor: Colors.black,
                                padding: EdgeInsets.all(5),

                              )

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
  }
}


Widget _buildSvgPicture(String url) {
  return SvgPicture.asset(
    url,
    fit: BoxFit.cover,
    height: 30,
    width: 30,
  );
}
