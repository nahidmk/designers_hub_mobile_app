import 'package:designers_hub_modile_app/Model/widget_helper_models/textFieldProperties.dart';
import 'package:designers_hub_modile_app/Provider/profile_provider.dart';
import 'package:designers_hub_modile_app/helper/colors.dart';
import 'package:designers_hub_modile_app/widget/common/Text_field_with_validation.dart';
import 'package:designers_hub_modile_app/widget/signin_signup_form/helper_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInFrom extends StatefulWidget {

  final Function toggleForm;
  final  bool popAble;


  SignInFrom({ required this.toggleForm, this.popAble = true});

  @override
  _SignInFromState createState() => _SignInFromState();
}

class _SignInFromState extends State<SignInFrom> {

  String _errorMessage = '';
  late OverlayEntry _overlayEntry;

  _showErrorOnUI(String data) {
    _showLoadingOverlay(
      context: context,
      child: Container(
          width: 250,
          height: 220,
          decoration: BoxDecoration(
              color: Color(0xfff2f5e9),
              borderRadius: BorderRadius.all(Radius.circular(5))
          ),
          child: Container(
              margin: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.cancel,
                      size: 60.0,
                      color: Color(0xFFD23600),
                    ),
                  ),
                  Text(
                    data,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 18,
                      fontFamily: "Poppins",
                    ),
                  ),
                ],
              )
          )
      ),
    );
  }

  void _showLoadingOverlay({
    required BuildContext context,
    required  Widget child
  }) {
    _overlayEntry = OverlayEntry(builder: (context) {
      return Scaffold(
          body: Stack(
            children: <Widget>[
              Positioned(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                top: 0,
                left: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      color: Color(0x9f000000)
                  ),
                  child: Center(
                    child: child,
                  ),
                ),
              ),
            ],
          )
      );
    }
    );

    return Overlay.of(context)!.insert(
      _overlayEntry,
    );
  }

  final _phoneNumberProperties =  TextFieldProperties(
      controller: new TextEditingController(),
      label: 'Phone number',
      inputType: 'number',
      keyboardType: TextInputType.number,

      required: true,
      validate: (String text) {
        if (text.length < 10 || text.length > 10) {
          return 'Phone number must be 10 digits.';
        } else
          return '';
      });

  final _passwordProperties =  TextFieldProperties(
      controller: new TextEditingController(),
      label: 'Password',
      inputType: 'text',
      keyboardType: TextInputType.text,
      required: true,
      validate: (String text) {
        if (text.isEmpty) {
          return 'Please enter your password';
        }
        return '';
      });

  bool _hidePassword = true;

  _onChange() {}

  _toggleHideOrShowPassword() {
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }

  _checkFormValidity() {
    bool valid = true;
    [_phoneNumberProperties, _passwordProperties].forEach((element) {
      if (element.controller.text.isEmpty) {
        setState(() {
          _errorMessage = 'Please fill all the * marked fields';
        });
        valid = false;
        return;
      }
      else if (element.validate(element.controller.text).length > 0) {
        setState(() {
          _errorMessage = 'Please validate the form.';
        });
        valid = false;
        return;
      }
    });

    return valid;
  }

  _signIn() async {
    setState(() {
      _errorMessage = '';
    });

    if (_checkFormValidity()) {
      ProfileProvider profileProvider =
      Provider.of<ProfileProvider>(context, listen: false);
      bool signedIn = await profileProvider.signIn(
          '+880${_phoneNumberProperties.controller.text}',
          _passwordProperties.controller.text);

      if (signedIn && widget.popAble != null) {
        // Provider.of<OrderProvider>(context, listen: false).getOnGoingOrderCountWithTopics();
        print('hello i am sigin---->');
        Navigator.pop(context);
      }
    }
  }

  _dismissErrorMsg() {
    setState(() {
      _errorMessage = '';
    });

    Provider.of<ProfileProvider>(context, listen: false).signInErrorMsg = '';
  }

  final BoxDecoration _textFieldDecoration = BoxDecoration(
    color: LIGHT_GRAY,
    borderRadius: BorderRadius.all(Radius.circular(10)),
  );

  @override
  Widget build(BuildContext context) {
    ProfileProvider profileProvider = Provider.of<ProfileProvider>(context);

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Container(
              child: Image.asset(
                'assets/images/2.jpg',
                height: 100,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              child: Column(
                children: <Widget>[
                  ShowErrorMsgIfNeeded(_errorMessage.length > 0 ? _errorMessage : profileProvider.signInErrorMsg, _dismissErrorMsg),
                  TextFieldWithValidation(
                    padding: EdgeInsets.only(bottom: 10),
                    prefix: buildPrefix(),
                    properties: _phoneNumberProperties,
                    keyboardType: TextInputType.number,
                    decoration: _textFieldDecoration,
                    onChange: _onChange,
                  ),
                  TextFieldWithValidation(
                    padding: EdgeInsets.only(bottom: 0),
                    obscureText: _hidePassword,
                    properties: _passwordProperties,
                    suffix:
                    buildToggleHideOrShowButton(_toggleHideOrShowPassword),
                    decoration: _textFieldDecoration,
                    onChange: _onChange,
                  ),
                  GestureDetector(
                    child: Align(alignment: Alignment.topRight,child: Text('Forgot password ?', style: TextStyle(color: Colors.black54),)),
                    onTap: (){
                      // Navigator.pushNamed(context, ForGotPasswordScreen.routeName);
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  profileProvider.signInLoading
                      ? CupertinoActivityIndicator(
                    radius: 15,
                  )
                      :
                  RaisedButton(
                    color: CUSTOMER,
                    child: Center(
                      child: Text(
                        'SIGN IN',
                        style: TextStyle(
                            color: CupertinoColors.white,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    onPressed: _signIn,
                  ),
                  CupertinoButton(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                              color: CupertinoColors.systemGrey, // Text colour here
                              width: 1.0, // Underline width
                            )),
                      ),
                      child: Text(
                        'Create an account',
                        style: TextStyle(
                          color: CupertinoColors.systemGrey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    onPressed: () {
                      widget.toggleForm(true);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
