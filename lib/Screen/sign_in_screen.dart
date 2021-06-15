import 'package:designers_hub_modile_app/widget/signin_signup_form/signin_form.dart';
import 'package:designers_hub_modile_app/widget/signin_signup_form/signup_form.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  bool _signUpForm = false;

  void swapSignupForm(bool value){
    setState(() {
      _signUpForm = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _signUpForm ?
      SignUpForm(toggleForm: swapSignupForm) :
      SignInFrom(toggleForm: swapSignupForm,),
    );
  }
}
