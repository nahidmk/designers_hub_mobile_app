import 'package:flutter/material.dart';


 MaterialButton primaryButton(VoidCallback function, String name,BuildContext context) => (
    MaterialButton(
      onPressed: function,
      child: Text(
        name,
        style: Theme.of(context).textTheme.button,
      ),
      color: Colors.purpleAccent,
      splashColor: Colors.greenAccent,
      highlightElevation: 30.0,
      textColor: Colors.white,
      padding: EdgeInsets.all(5),

    )
);
MaterialButton secondaryButton(VoidCallback function, String name,BuildContext context) => (
    MaterialButton(
      onPressed: function,
      child: Text(
        name,
        style: Theme.of(context).textTheme.button,
      ),
      color: Colors.black,
      splashColor: Colors.greenAccent,
      highlightElevation: 30.0,
      textColor: Colors.black,
      padding: EdgeInsets.all(5),

    )
);

MaterialButton dangerButton(VoidCallback function, String name,BuildContext context) => (
    MaterialButton(
      onPressed: function,
      child: Text(
        name,
        style: Theme.of(context).textTheme.button,
      ),
      color: Colors.red,
      splashColor: Colors.greenAccent,
      highlightElevation: 30.0,
      textColor: Colors.white,
      padding: EdgeInsets.all(5),

    )
);