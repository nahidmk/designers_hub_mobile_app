import 'package:designers_hub_modile_app/Model/widget_helper_models/textFieldProperties.dart';
import 'package:designers_hub_modile_app/widget/common/Text_field_with_validation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FormAttribute extends StatelessWidget {
  final Widget icon;
  final TextFieldProperties properties;
  final Function onChange;


  FormAttribute({required this.icon, required this.properties, required this.onChange});

  static final BoxDecoration textFieldDecoration = const BoxDecoration(
      border: Border(
          bottom: BorderSide(
              color: CupertinoColors.activeOrange,
              width: 1)));

  static final TextStyle labelStyle = const TextStyle(
      color: Colors.black54, fontWeight: FontWeight.w400, fontSize: 12);

  static final TextStyle textStyle = const TextStyle(
      color: CupertinoColors.black,
      fontWeight: FontWeight.w300,
      fontSize: 15);

  



  @override
  Widget build(BuildContext context) {


    return Container(
    width: MediaQuery.of(context).size.width - 40,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
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
          icon,
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: TextFieldWithValidation(
              padding: EdgeInsets.all(0),
              properties: properties,
              lineGap: 0,
              labelStyle: labelStyle,
              textStyle: textStyle,
              textFieldPadding: EdgeInsets.all(5),
              onChange: onChange,
              decoration: textFieldDecoration,
              keyboardType: properties.keyboardType,
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildSvgPicture(String url) {
  return SvgPicture.asset(
    url,
    fit: BoxFit.cover,
    height: 30,
    width: 30,
  );
}