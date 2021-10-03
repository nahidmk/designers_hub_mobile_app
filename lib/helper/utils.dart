import 'dart:convert';
import 'dart:io';

import 'package:designers_hub_modile_app/Provider/profile_provider.dart';
import 'package:designers_hub_modile_app/Screen/sign_in_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

String showApiErrorMessage(error, BuildContext context) {
  try {
    if (error is SocketException) {
      showErrorMessage("No internet connection !", context);
      return "No internet connection !";
    } else if (error is Response) {
      if (error.statusCode == 401) {
        showErrorMessage('Session expired', context);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (_) => SignInScreen(false)));
        return 'Session expired';
      } else if (error.statusCode == 403) {
        Provider.of<ProfileProvider>(context, listen: false).signOut();
        showErrorMessage(json.decode(error.body)['message'], context);
      }
      showErrorMessage(json.decode(error.body)['message'], context);
      return json.decode(error.body)['message'];
    } else {
      showErrorMessage(error.toString(), context);
      return error.toString();
    }
  } catch (err) {
    showErrorMessage("Something went wrong. Please try again later !", context);
    return "Something went wrong. Please try again later !";
  }
}

String showErrorMessage(String errorMsg, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      errorMsg,
      style: TextStyle(color: Theme.of(context).errorColor),
    ),
  ));

  return errorMsg;
}

void showSuccessMessage(String successMsg, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      successMsg,
      style: TextStyle(color: Colors.green),
    ),
  ));
}

void showWarningMessage(String errorMsg, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      errorMsg,
      style: TextStyle(color: Theme.of(context).errorColor),
    ),
  ));
}

Map<String, String> getAuthHeader(String authToken) {
  Map<String, String> header = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $authToken',
  };

  return header;
}

String getNullSafetyText(String? text) {
  return text ?? '';
}

bool isNumeric(String? s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}

http.Response refreshToken(http.Response response) {
  if ((response.statusCode == 200 || response.statusCode == 201) &&
      response.headers['x-jwt'] != null) {
    print('x headedr ---> ${response.headers['x-jwt']}');
  }

  return response;
}



String getDeviceType(BuildContext context) {
//  final data = MediaQueryData.fromWindow(WidgetsBinding.instance?.window??);
  final shortestSide = MediaQuery.of(context).size.shortestSide;
  return shortestSide < 600 ? 'phone' : 'tablet';
}
