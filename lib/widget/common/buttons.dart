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

Container outlinedButton(VoidCallback function, String name,BuildContext context) => (
    Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black54)
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          name,
          style: TextStyle(color: Colors.black),
        ),
        splashColor: Colors.greenAccent,
        highlightElevation: 30.0,
        textColor: Colors.black,
      ),
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

MaterialButton AppBarButton(VoidCallback function, String name,BuildContext context) => (
    MaterialButton(
      onPressed: function,
      child: Text(
        name,
        style: TextStyle(fontWeight: FontWeight.w300,fontSize: 10),
      ),

      color: Colors.black,
      splashColor: Colors.greenAccent,
      highlightElevation: 30.0,
      textColor: Colors.white,
      padding: EdgeInsets.all(5),

    )


);

