
import 'package:designers_hub_modile_app/Model/user.dart';
import 'package:designers_hub_modile_app/Model/widget_helper_models/textFieldProperties.dart';
import 'package:designers_hub_modile_app/helper/colors.dart';
import 'package:designers_hub_modile_app/helper/text.dart';
import 'package:designers_hub_modile_app/widget/common/Text_field_with_validation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


import 'helper_widgets.dart';

class SignUpForm extends StatefulWidget {
  final Function toggleForm;
  final bool popAble;

  SignUpForm({required this.toggleForm, this.popAble = true});

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  // TextFieldProperties _firstNameProperties;
  // TextFieldProperties _phoneNumberProperties;
  // TextFieldProperties _passwordProperties;
  // TextFieldProperties _confirmPasswordProperties;

  _checkPassword(String text) {
    if (text != _passwordProperties.controller.text) {
      return 'Does not match password.';
    } else
      return '';
  }

  TextFieldProperties _firstNameProperties =  TextFieldProperties(
  controller: TextEditingController(),
  label: 'Full Name',
  required: true,
  inputType: "text",
  keyboardType: TextInputType.text,
  validate: (String text) {
  if (text.length < 1) {
  return 'Too small.';
  } else if (text.length > 20) {
  return 'Too long';
  } else
  return '';
  });



  TextFieldProperties _phoneNumberProperties = new TextFieldProperties(
  controller: new TextEditingController(),
  label: 'Phone number',
  required: true,
  inputType: "number",
  keyboardType: TextInputType.number,
  validate: (String text) {
  if (text.length < 10 || text.length > 10) {
  return 'Phone number must be 10 digits.';
  } else
  return '';
  });

  TextFieldProperties _passwordProperties = new TextFieldProperties(
  controller: new TextEditingController(text: ''),
  label: 'Password',
  required: true,
  inputType: "text",
  keyboardType: TextInputType.text,
  validate: (String text) {
  if (text.isEmpty) {
  return 'Please enter your password';
  }
  if (text.length < 6) {
  return 'At least 6 character';
  }
  return '';
  });

  TextFieldProperties _confirmPasswordProperties = new TextFieldProperties(
  controller: new TextEditingController(),
  label: 'Confirm password',
  inputType: "text",
  keyboardType: TextInputType.text,
  required: true,
  validate: (String text) {
  if (text.isEmpty) {
  return 'Please confirm your password';
  }
  });
  @override
  void initState() {

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _confirmPasswordProperties = new TextFieldProperties(
          controller: new TextEditingController(),
          label: 'Confirm password',
          inputType: "text",
          keyboardType: TextInputType.text,
          required: true,
          validate: (String text) {
            if (text.isEmpty) {
              return 'Please confirm your password';
            }
            return _checkPassword(text);
          });
    });

  }


  String _errorMessage = '';
  bool termsAndConditions = false;

  bool _hidePassword = true;

  _toggleHideOrShowPassword() {
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }

  _onChange() {}

  _checkFormValidity() {
    bool valid = true;
    [
      _phoneNumberProperties,
      _passwordProperties,
      _firstNameProperties,
      _confirmPasswordProperties
    ].forEach((element) {
      if (element.controller.text.isEmpty) {
        setState(() {
          _errorMessage = 'Please fill all the * marked fields';
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

    if (valid && !termsAndConditions) {

      Fluttertoast.showToast(msg: "You must accept privacy policy and terms & conditions in order to sign up for $APP_NAME ");
      return false;
    }

    return valid;
  }

  _signUp() async {
    setState(() {
      _errorMessage = '';
    });

    // if (_checkFormValidity()) {
    //   await Provider.of<ProfileProvider>(context, listen: false).sendOTP(
    //       primaryPhone: '+880${_phoneNumberProperties.controller.text}');
    // }
  }

  _dismissErrorMsg() {
    setState(() {
      _errorMessage = '';
    });

    // Provider.of<ProfileProvider>(context, listen: false)
    //     .phoneVerificationErrorMsg = '';
    // Provider.of<ProfileProvider>(context, listen: false).signUpErrorMsg = '';
  }

  final BoxDecoration _textFieldDecoration = BoxDecoration(
    color: LIGHT_GRAY,
    borderRadius: BorderRadius.all(Radius.circular(10)),
  );

  // TextEditingController _otpController = new TextEditingController();

//  @override
//  void didChangeDependencies() {
//    // TODO: implement didChangeDependencies
//    super.didChangeDependencies();
//
////    if(Provider.of<ProfileProvider>(context, listen: false).isAuthenticated && Navigator.canPop(context)){
////      Navigator.pop(context);
////    }
//  }

  @override
  Widget build(BuildContext context) {
    // ProfileProvider profileProvider = Provider.of<ProfileProvider>(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        child:
        // profileProvider.phoneCodeSent
        //     ? OTPForm(
        //         controller: _otpController,
        //         user: new User(
        //             primaryPhone:
        //                 '+880${_phoneNumberProperties.controller.text}',
        //             name: new Name(
        //                 firstName: _firstNameProperties.controller.text,
        //                 lastName: _lastNameProperties.controller.text),
        //             password: _passwordProperties.controller.text,
        //             referralBy: _refCodeProperties.controller.text
        //         ),
        //         dismissErrorMsg: _dismissErrorMsg,
        //         popAble: widget.popAble,
        //         resend: _signUp
        // )
            Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    TextFieldWithValidation(
                      padding: EdgeInsets.only(bottom: 10),
                      properties: _firstNameProperties,
                      decoration: _textFieldDecoration,
                      onChange: _onChange,
                    ),
                    TextFieldWithValidation(
                      padding: EdgeInsets.only(bottom: 10),
                      prefix: buildPrefix(),
                      properties: _phoneNumberProperties,
                      keyboardType: TextInputType.phone,
                      decoration: _textFieldDecoration,
                      onChange: _onChange,
                    ),
                    TextFieldWithValidation(
                      padding: EdgeInsets.only(bottom: 20),
                      obscureText: _hidePassword,
                      properties: _passwordProperties,
                      suffix: buildToggleHideOrShowButton(
                          _toggleHideOrShowPassword),
                      decoration: _textFieldDecoration,
                      onChange: _onChange,
                    ),
                    TextFieldWithValidation(
                      padding: EdgeInsets.only(bottom: 20),
                      obscureText: _hidePassword,
                      properties: _confirmPasswordProperties,
                      suffix: buildToggleHideOrShowButton(
                          _toggleHideOrShowPassword),
                      decoration: _textFieldDecoration,
                      onChange: _onChange,
                    ),
                    Material(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: termsAndConditions,


                                onChanged: (value) {
                                  setState(() {
                                    termsAndConditions = value!;
                                  });
                                },
                              ),
                              Text(
                                "Please agree with terms and conditions",
                                style:
                                TextStyle(color: CupertinoColors.activeOrange, fontSize: 12),
                              ),
                            ],

                          ),

                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // ShowErrorMsgIfNeeded(
                    //     _errorMessage.length > 0
                    //         ? _errorMessage
                    //         : profileProvider.signUpErrorMsg,
                    //     _dismissErrorMsg),
                    // profileProvider.signUpLoading
                    //     ? CupertinoActivityIndicator(
                    //         radius: 15,
                    //       )
                    //     :
                    SizedBox(
                            width: double.infinity,
                            child: CupertinoButton(
                              child: Text(
                                'SUBMIT',
                                style: TextStyle(
                                    color: CupertinoColors.white,
                                    fontWeight: FontWeight.w300),
                              ),
                              color: CUSTOMER,
                              onPressed: _signUp,
                            ),
                          ),
                    _buildAlreadyHaveAccountMsg(
                        widget.toggleForm, _dismissErrorMsg),

                    SizedBox(height: 70,)
                  ],
                ),
              ),
      ),
    );
  }
}

Widget _buildAlreadyHaveAccountMsg(
    Function toggleForm, Function _dismissErrorMsg) {
  return Center(
      child: Row(
    children: <Widget>[
      Text('Already have an account ?'),
      CupertinoButton(
        child: Text(
          'Sign in',
          style: TextStyle(
              color: CupertinoColors.systemBlue, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          _dismissErrorMsg();
          toggleForm(false);
        },
      ),
    ],
  ));
}

// class OTPForm extends StatelessWidget {
//   final TextEditingController controller;
//   final User user;
//   final Function dismissErrorMsg;
//   final String popAble;
//   final Function resend;
//
//   OTPForm(
//       {this.controller,
//       this.user,
//       this.dismissErrorMsg,
//       this.popAble,
//       this.resend});
//
//   @override
//   Widget build(BuildContext context) {
//     ProfileProvider profileProvider =
//         Provider.of<ProfileProvider>(context, listen: false);
//
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.all(20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           Text(
//             'We sent a verification code to your phone.',
//             style: TextStyle(fontWeight: FontWeight.w500),
//           ),
//           Text(
//             'Please Enter your verification code here.',
//             style: TextStyle(fontWeight: FontWeight.w500),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           SizedBox(
//             width: 100,
//             child: CupertinoTextField(
//               controller: controller,
//               keyboardType: TextInputType.number,
//               style: TextStyle(fontSize: 20),
//               autofocus: true,
//               textAlign: TextAlign.center,
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               profileProvider.signUpLoading
//                   ? CupertinoActivityIndicator(
//                       radius: 15,
//                     )
//                   : CupertinoButton(
//                       onPressed: resend,
//                       child: Text(
//                         'Resend code',
//                         style: TextStyle(
//                             color: CupertinoColors.systemBlue,
//                             fontWeight: FontWeight.w600),
//                       ),
//                     ),
//               CupertinoButton(
//                 onPressed: () {
//                   profileProvider.phoneCodeSent = false;
//                 },
//                 child: Text(
//                   'Cancel',
//                   style: TextStyle(
//                       color: CupertinoColors.activeOrange,
//                       fontWeight: FontWeight.w600),
//                 ),
//               )
//             ],
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           ShowErrorMsgIfNeeded(
//               profileProvider.phoneVerificationErrorMsg, dismissErrorMsg),
//           profileProvider.phoneVerificationLoading
//               ? CupertinoActivityIndicator(
//                   radius: 15,
//                 )
//               : CupertinoButton(
//                   color: CUSTOMER,
//                   child: Text(
//                     'Submit code',
//                     style: TextStyle(color: CupertinoColors.white),
//                   ),
//                   onPressed: () async {
//                     bool status = await profileProvider.signUpWithOTP(
//                         controller.text, user);
//                     if (status)
//                       Provider.of<OrderProvider>(context, listen: false)
//                           .getOnGoingOrderCountWithTopics();
//                     if (popAble != null) {
//                       Navigator.pop(context);
//                     }
//                   },
//                 )
//         ],
//       ),
//     );
//   }
// }
