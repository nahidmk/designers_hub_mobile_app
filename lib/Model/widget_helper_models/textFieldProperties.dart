import 'package:flutter/cupertino.dart';
import 'package:os_ios/models/enums/input_types.dart';

class TextFieldProperties {
  TextEditingController controller;
  String label;
  bool touched;
  bool required;
  Function validate;
  String selectedDate;
  TextInputType keyboardType;
  InputTypes inputType;
  int maxLine;

  TextFieldProperties(
      {this.controller, this.label,this.keyboardType, this.touched,this.required = false, this.validate, this.selectedDate, this.inputType, this.maxLine = 1});
}
