import 'package:designers_hub_modile_app/Model/widget_helper_models/textFieldProperties.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class TextFieldWithValidation extends StatefulWidget {
  final BoxDecoration decoration;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? prefix;
  final Widget? suffix;
  final EdgeInsetsGeometry padding;
  final double lineGap;
  final EdgeInsets textFieldPadding;
  final TextFieldProperties properties;
  final Function onChange;
  final TextStyle labelStyle;
  final TextStyle textStyle;

  TextFieldWithValidation(
      {
         required this.properties,
         this.prefix,
         this.suffix,
        required this.decoration,
        this.keyboardType = TextInputType.text,
        this.obscureText = false,
        required this.padding,
        this.lineGap = 10,
        this.labelStyle = const TextStyle(
          color: Color(0xff120c33), fontWeight: FontWeight.w500),
        this.textStyle = const TextStyle(fontSize: 16),
        this.textFieldPadding = const EdgeInsets.all(10),
        required this.onChange
      });

  @override
  _TextFieldWithValidationState createState() => _TextFieldWithValidationState();
}

class _TextFieldWithValidationState extends State<TextFieldWithValidation> {
  String _errorMsg = '';

//  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime(2000, 1),
        firstDate: DateTime(1950, 8),
        lastDate: DateTime(2201));

    if(picked  == null) return;

    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formatted = formatter.format(picked);

    if (picked != null) widget.onChange(formatted);
  }


  @override
  Widget build(BuildContext context) {
    Widget field;

    switch (widget.properties.inputType) {
      case 'date':
        field = Container(
          decoration: widget.decoration,
          width: double.infinity,
          child: CupertinoButton(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('${widget.properties.selectedDate}'),
            ),
            onPressed: () => _selectDate(context),
          ),
        );
        break;

      default:
        field = CupertinoTextField(
          obscureText: widget.obscureText,
          padding: widget.textFieldPadding,
          prefix: widget.prefix,
          suffix: widget.suffix,
          controller: widget.properties.controller,
          decoration: widget.decoration,
          style: widget.textStyle,
          keyboardType: widget.keyboardType,
          maxLines: widget.properties.maxLine,
          onChanged: (text) {
            widget.onChange();
            setState(() {
              _errorMsg = widget.properties.validate(text);
            });
          },
        );
        break;
    }

    return Container(
      padding: widget.padding != null ? widget.padding : EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildLabel(widget.properties.label, widget.properties.required,
              widget.labelStyle),
          SizedBox(
            height: widget.lineGap,
          ),
          field,
          SizedBox(
            height: 5,
          ),
          if (widget.properties.inputType != 'date')
            Text(
              _errorMsg,
              style:
                  TextStyle(color: CupertinoColors.activeOrange, fontSize: 12),
            ),
        ],
      ),
    );
  }
}

Widget _buildLabel(String label, bool required, TextStyle style) {
  return Row(
    children: <Widget>[
      required
          ? Text(
              '* ',
              style: TextStyle(color: CupertinoColors.systemRed),
            )
          : SizedBox(),
      Text(
        label,
        style: style,
      ),
    ],
  );
}
