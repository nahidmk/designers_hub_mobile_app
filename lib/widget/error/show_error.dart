

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ShowError extends StatelessWidget {

  String errorMsg;
  Function onReload;

  ShowError({required this.errorMsg,required this.onReload});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CupertinoColors.white,
      width: double.infinity,
      child: FlatButton(
        onPressed: (){
          onReload();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/images/no-signal.svg', height: 100, width: 100,),
            SizedBox(height: 20,),
            Text(errorMsg, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black54,)),
            Text('Tap to reconnect.', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black54))
          ],
        ),
      ),
    );
  }
}
