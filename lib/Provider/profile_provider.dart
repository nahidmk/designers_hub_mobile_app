
import 'dart:convert';
import 'dart:io';

import 'package:designers_hub_modile_app/Model/fcm_device_reg_token.dart';
import 'package:designers_hub_modile_app/Model/user.dart';
import 'package:designers_hub_modile_app/Service/profile_service.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:firebase_messaging/firebase_messaging.dart';

class ProfileProvider extends ChangeNotifier{

  ProfileService get profileService => GetIt.I<ProfileService>();

  late FirebaseMessaging _firebaseMessaging;

  bool _signInLoading = false;
  String _signInErrorMsg = '';

  bool _signUpLoading = false;
  String _signUpErrorMsg = '';

  bool _profileLoading = true;
  String _profileErrorMsg = '';

  bool _isAuthenticated = false;

  String _verificationId="";
  bool _phoneCodeSent = false;
  String _phoneVerificationErrorMsg = '';


  String get verificationId => _verificationId;

  set verificationId(String value) {
    _verificationId = value;
    notifyListeners();
  }

  bool get isAuthenticated => _isAuthenticated;

  set isAuthenticated(bool value) {
    _isAuthenticated = value;
    notifyListeners();
  }

  User _profile = User(active: false, address: "", banned: false, dateOfBirth: "", disabled: false, email: "", fullName: "", gender: "", id: 0, nid: "", nidPictureBack: "", nidPictureFront: "", primaryNumber: '', profilePicture: "", provider: "", providerId: "", secondaryNumber: "");


  User get profile => _profile;

  set profile(User value) {
    _profile = value;
    notifyListeners();
  }

  bool get signInLoading => _signInLoading;

  set signInLoading(bool value) {
    _signInLoading = value;
    notifyListeners();
  }

  String get signInErrorMsg => _signInErrorMsg;

  set signInErrorMsg(String value) {
    _signInErrorMsg = value;
    notifyListeners();
  }

  String get profileErrorMsg => _profileErrorMsg;

  set profileErrorMsg(String value) {
    _profileErrorMsg = value;
    notifyListeners();
  }

  bool get profileLoading => _profileLoading;

  set profileLoading(bool value) {
    _profileLoading = value;
    notifyListeners();
  }

  String get signUpErrorMsg => _signUpErrorMsg;

  set signUpErrorMsg(String value) {
    _signUpErrorMsg = value;
    notifyListeners();
  }

  bool get signUpLoading => _signUpLoading;

  set signUpLoading(bool value) {
    _signUpLoading = value;
    notifyListeners();
  }



  Future<bool> signIn(String username, String password) async {
    try {
      print('sign in function called---->');
      signInLoading = true;
      signInErrorMsg = '';
      final response = await profileService.signIn(username, password);
      if (response.statusCode == 200) {
        print('access token ----->${json.decode(response.body)}');
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(
            'aw_auth_token', json.decode(response.body)['token']['access']);
        prefs.setString('username', username);
        prefs.setString('password', password);
        bool status = await getProfile();
        if(!status) {
          signInErrorMsg = 'Something went wrong. Please try again later.';
          signInLoading = false;
          return false;
        }
        signInLoading = false;
        return true;
      } else {
        print('sign in failed---->');
        signInLoading = false;
        signInErrorMsg = json.decode(response.body)['message'];
        return false;
      }
    } catch (error) {
      print("error----->$error.toString()");
      signInLoading = false;
      signInErrorMsg = getErrorMsg(error);
      return false;
    }
  }

  String getErrorMsg(error){
    if (error is SocketException) {
      return 'Please check your internet connection !';
    }
    else{
      return 'Something went wrong. Please try again later !';
    }
  }



  Future<bool> getProfile() async {
    profileLoading = true;
    profileErrorMsg = '';

    try {
      var response = await profileService.getProfile();
      if (response.statusCode == 200) {
        print('profile response --->${json.decode(response.body)}');
        User user = User.fromJson(json.decode(response.body));
        _profile = user;

        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? deviceFCMToken = prefs.getString("device_fcm_token");

        // if (deviceFCMToken != null) {
        //   FCMDeviceRegToken deviceRegToken = FCMDeviceRegToken.fromJson(json.decode(deviceFCMToken));
        //   deviceRegToken.userId = user.id;
        //   fcmDeviceRegToken(deviceRegToken);
        // }

        isAuthenticated = true;
        profileLoading = false;
        return true;
      } else if (response.statusCode == 401) {
        bool status = await recoverProfile();
        return status;
      }
    } catch (error) {
      print( 'get profile error---->$error');
      profileErrorMsg = getErrorMsg(error);
      profileLoading = false;
      return false;
    }

    return true;
  }

  Future<bool> recoverProfile() async {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? username = prefs.getString('username');
      String? password = prefs.getString('password');
      if(username == null || password == null){
        return false;
      }

      bool status = await signIn( username, password);
      if (status == false) {
        signInErrorMsg = '';
        isAuthenticated = false;
        return false;
      }
      profileLoading = false;
      return true;
    }catch(error){
      return false;
    }
  }

  bool get phoneCodeSent => _phoneCodeSent;

  set phoneCodeSent(bool value) {
    _phoneCodeSent = value;
    notifyListeners();
  }

  String get phoneVerificationErrorMsg => _phoneVerificationErrorMsg;

  set phoneVerificationErrorMsg(String value) {
    _phoneVerificationErrorMsg = value;
    notifyListeners();
  }

  // Future<bool> sendOTP({primaryPhone}) async {
  //   print('sent otp called------<><><><><>');
  //   signUpLoading = true;
  //
  //   signUpErrorMsg = '';
  //
  //   final PhoneVerificationCompleted verified = (AuthCredential authResult) {
  //     print('completed---> ${json.decode(authResult.toString())}');
  //     signUpLoading = false;
  //   };
  //
  //   final PhoneVerificationFailed verificationFailed =
  //       (AuthException authException) {
  //     print('${authException.message}');
  //     signUpErrorMsg = 'Phone verification failed.';
  //     signUpLoading = false;
  //   };
  //
  //   final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
  //     print('phone code sent --->$verId');
  //     verificationId = verId;
  //
  //     phoneCodeSent = true;
  //     signUpLoading = false;
  //   };
  //
  //   final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
  //     phoneVerificationErrorMsg = 'Time out !';
  //     verificationId = verId;
  //   };
  //
  //   FirebaseAuth _auth = FirebaseAuth.instance;
  //   try {
  //     _auth.verifyPhoneNumber(
  //       phoneNumber: primaryPhone,
  //       timeout: Duration(seconds: 120),
  //       verificationCompleted: verified,
  //       verificationFailed: verificationFailed,
  //       codeSent: smsSent,
  //       codeAutoRetrievalTimeout: autoTimeout,
  //     );
  //   } catch (error) {
  //     print('google error---> ${error}');
  //     signUpErrorMsg = 'Unexpected error !';
  //     signUpLoading = false;
  //   }
  //   return false;
  // }

// void fcmDeviceRegToken(FCMDeviceRegToken fcmDeviceRegToken) async {
  //   try {
  //     final response = await commonService.fcmDeviceRegToken(fcmDeviceRegToken);
  //
  //     if (response.statusCode == 200) {
  //       print(response.body);
  //
  //       _fcmRegToken = FCMDeviceRegToken.fromJson(json.decode(response.body));
  //
  //       print('FCM Reg toke: $_fcmRegToken');
  //
  //       SharedPreferences prefs = await SharedPreferences.getInstance();
  //       prefs.setString("device_fcm_token", json.encode(_fcmRegToken));
  //     } else {
  //       print(response.body);
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }
}