import 'package:designers_hub_modile_app/widget/signin_signup_form/signin_form.dart';
import 'package:designers_hub_modile_app/widget/signin_signup_form/signup_form.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {

 final bool fromAccount;

 SignInScreen(this.fromAccount);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  bool _signUpForm = false;

  void swapSignupForm(bool value){
    setState(() {
      _signUpForm = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.fromAccount?Scaffold(
      body: _signUpForm ?
      SignUpForm(toggleForm: swapSignupForm) :
      SignInFrom(toggleForm: swapSignupForm,),
    ):
    Scaffold(
      appBar: AppBar(),
      body: _signUpForm ?
      SignUpForm(toggleForm: swapSignupForm) :
      SignInFrom(toggleForm: swapSignupForm,),
    );

  }
}
