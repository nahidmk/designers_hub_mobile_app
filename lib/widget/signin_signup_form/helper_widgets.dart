import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

Widget buildToggleHideOrShowButton(toggleHideOrShowPassword) {
  return SizedBox(
    height: 35,
    width: 30,
    child: FittedBox(
      child: CupertinoButton(
        child: Icon(
          CupertinoIcons.eye_solid,
          size: 60,
        ),
        onPressed: toggleHideOrShowPassword,
      ),
    ),
  );
}

Widget buildPrefix() {
  return Row(
    children: <Widget>[
      Padding(
        padding: EdgeInsets.all(8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(3.0),
          child: Image.asset(
            'assets/images/1.jpg',
            fit: BoxFit.cover,
            height: 16,
            width: 16 * 1.5,
          ),
        ),
      ),
      Text(
        '+880',
        style: TextStyle(fontSize: 16),
      ),
    ],
  );
}

class ShowErrorMsgIfNeeded extends StatelessWidget {

  final _errorMessage;
  final _dismissErrorMsg;

  ShowErrorMsgIfNeeded(this._errorMessage, this._dismissErrorMsg);


  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      transitionBuilder: (widget, animation) {
        return FadeTransition(child: widget, opacity: animation,);
      },
      duration: Duration(milliseconds: 500),
      child: _errorMessage != ''
          ? _buildErrorMsg(context, _errorMessage, _dismissErrorMsg)
          : SizedBox(),
    );
  }
}


Widget _buildErrorMsg(BuildContext context, String msg, VoidCallback dismissErrorMsg) {
  return Padding(
    padding: const EdgeInsets.only(bottom:20.0),
    child: Container(
        padding: EdgeInsets.only(left: 10),
        width: MediaQuery.of(context).size.width - 20,
        decoration: BoxDecoration(
          color: Color(0xffffcccc),
//      color: CupertinoColors.systemRed,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: CupertinoColors.inactiveGray.withOpacity(1),
              spreadRadius: -7,
              blurRadius: 15,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(child: Text(msg, maxLines: 3, style: TextStyle(color: CupertinoColors.systemRed))),
            SizedBox(
              height: 40,
              child: FittedBox(
                child: CupertinoButton(
                  onPressed: dismissErrorMsg,
                  child: Icon(
                    CupertinoIcons.clear_circled,
                    color: CupertinoColors.systemRed,
                  ),
                ),
              ),
            )
          ],
        )),
  );
}