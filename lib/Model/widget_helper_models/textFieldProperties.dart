import 'package:flutter/cupertino.dart';

class TextFieldProperties {
  TextEditingController controller;
  String label;
  bool touched;
  bool required;
  Function validate;
  String selectedDate;
  TextInputType keyboardType;
  String inputType;
  int maxLine;

  TextFieldProperties(
      {required this.controller,required this.label,required this.keyboardType, this.touched =false,this.required = false, required this.validate, this.selectedDate = '', required this.inputType, this.maxLine = 1});
}
