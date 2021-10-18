
import 'dart:convert';
import 'dart:io';

import 'package:designers_hub_modile_app/Model/fcm_device_reg_token.dart';
import 'package:designers_hub_modile_app/Model/user.dart';
import 'package:designers_hub_modile_app/Service/profile_service.dart';
import 'package:firebase_auth/firebase_auth.dart' as Firebse;
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

  String _forgotPasswordErrorMsg = '';
  bool _loadingForgotPassword = false;

  String get forgotPasswordErrorMsg => _forgotPasswordErrorMsg;

  set forgotPasswordErrorMsg(String value) {
    _forgotPasswordErrorMsg = value;
    notifyListeners();
  }

  bool _isAuthenticated = false;

  String _verificationId="";
  bool _phoneCodeSent = false;
  String _phoneVerificationErrorMsg = '';

  String _updateProfileErrorMsg = '';

  bool phoneVerificationLoading = false;

  String? _idToken = '';





  FirebaseMessaging get firebaseMessaging => _firebaseMessaging;

  set firebaseMessaging(FirebaseMessaging value) {
    _firebaseMessaging = value;
    notifyListeners();
  }

  String get updateProfileErrorMsg => _updateProfileErrorMsg;

  set updateProfileErrorMsg(String value) {
    _updateProfileErrorMsg = value;
    notifyListeners();
  }

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

  User _profile = User(active: false, address: "", password: '', banned: false, dateOfBirth: "", disabled: false, email: "", fullName: "", gender: "", id: 0, nid: "", nidPictureBack: "", nidPictureFront: "", primaryNumber: '', profilePicture: "", provider: "", providerId: "", secondaryNumber: "");


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

  bool get loadingForgotPassword => _loadingForgotPassword;

  set loadingForgotPassword(bool value) {
    _loadingForgotPassword = value;
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



  Future<bool> signIn(String username, String password) async {
    try {
      print('sign in function called---->');
      signInLoading = true;
      signInErrorMsg = '';
      final response = await profileService.signIn(username, password);
      print('response for signin----------->${json.decode(response.body)}');
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

  void isLogin() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? authToken = prefs.getString('aw_auth_token');

    if (authToken == null) {
      isAuthenticated = false;
    } else if (authToken.isEmpty) {
      isAuthenticated = false;
    } else {
      getProfile();
    }

  }

  void signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('aw_auth_token');
    isAuthenticated = false;
  }


  Future<bool> getProfile() async {
    profileLoading = true;
    profileErrorMsg = '';

    try {
      var response = await profileService.getProfile();
      if (response.statusCode == 200) {
        print('profile response --->${json.decode(response.body)}');
        User user = User.fromJson(json.decode(response.body)["info"]);
        _profile = user;
        print("user name---->${_profile.fullName}");
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

  Future<bool> updateProfile(User user) async {
    try {
      updateProfileErrorMsg = '';
      final response = await profileService.updateProfile(user);
      if (response.statusCode == 200) {
        profile = User.fromJson(json.decode(response.body));
        print("profile provider--->${profile.email}");
        return true;
      } else {
        print('update profile response error---> ${response.body}');
        updateProfileErrorMsg = json.decode(response.body)['message'];
        return false;
      }
    } catch (error) {
      print('update profile error --->$error');
      profileLoading = false;
      updateProfileErrorMsg = getErrorMsg(error);
      return false;
    }
  }


  Future<bool> isExistAccount(String phoneNumber) async{

    try{
      loadingForgotPassword = true;
      forgotPasswordErrorMsg = '';

      final response = await profileService.isExistAccount(phoneNumber);
      if(response.statusCode == 200){
        loadingForgotPassword = false;
        if(json.decode(response.body)['exist'] == true){
          await sendOTP(primaryPhone: '+880$phoneNumber');
          return true;
        }else{
          forgotPasswordErrorMsg = 'There is no account with this phone number.';
          return false;
        }
      }else{
        print("forgot password response error ---->${response.body}");
        loadingForgotPassword = false;
        forgotPasswordErrorMsg = json.decode(response.body)['errors'][0];
        return false;
      }

    }catch(error){
      print("forgot password error ---->${error}");
      forgotPasswordErrorMsg = getErrorMsg(error);
      return false;
    }
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





  Future<bool> sendOTP({primaryPhone}) async {

    print('sent otp called------<><><><><>');
    signUpLoading = true;

    signUpErrorMsg = '';

    final Firebse.PhoneVerificationCompleted verified = (Firebse.PhoneAuthCredential credential) {
      print('completed---> ${json.decode(credential.toString())}');
      signUpLoading = false;
    };


    final Firebse.PhoneVerificationFailed verificationFailed =
        (Firebse.FirebaseAuthException authException) {
      if(authException.code == 'invalid-phone-number'){
        print('The provided phone number is not valid.');
        signUpErrorMsg = 'The provided phone number is not valid';
      }
      signUpLoading = false;
    };

    final Firebse.PhoneCodeSent smsSent = (String verId, [int? forceResend]) {
      print('phone code sent --->$verId');
      verificationId = verId;

      phoneCodeSent = true;
      signUpLoading = false;
    };


    final Firebse.PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      phoneVerificationErrorMsg = 'Time out !';
      verificationId = verId;

    };

    Firebse.FirebaseAuth _auth = Firebse.FirebaseAuth.instance;
    try {
      _auth.verifyPhoneNumber(
        phoneNumber: primaryPhone,
        timeout: Duration(seconds: 120),
        verificationCompleted: verified,
        verificationFailed: verificationFailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout,

      );
    } catch (error) {
      print('google error---> ${error}');
      signUpErrorMsg = 'Unexpected error !';
      signUpLoading = false;
    }
    return false;
  }

  Future<bool> verifyOTP(smsCode) async {
    print('verification id ------->$verificationId');

    Firebse.AuthCredential authCredential = Firebse.PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);

    print('auth credential ----> $authCredential');

    try {
      Firebse.UserCredential authResult = await Firebse.FirebaseAuth.instance.signInWithCredential(authCredential);
      _idToken = await authResult.user?.getIdToken();
      print('idToken -----> ${_idToken}');
      return true;
    } catch (error) {
      print('error--->${error}');
      return false;
    }
  }


  Future<bool> signUpWithOTP(smsCode, User user) async {
    phoneVerificationLoading = true;
    phoneVerificationErrorMsg = '';

    bool verified = await verifyOTP(smsCode);

    if (!verified) {
      phoneVerificationLoading = false;
      phoneVerificationErrorMsg = "Invalid code !";
      return false;
    };


    final response = await profileService.signUp(user, _idToken);
    print('');
    if (response.statusCode == 200) {
      print('success---->${json.decode(response.body)}');
      signIn(user.primaryNumber, user.password);
      phoneVerificationLoading = false;
      return true;
    } else {
      print('failed---->${json.decode(response.body)}');
      signUpErrorMsg = 'Unexpected error !';
      phoneVerificationLoading = false;
      return false;
    }

  }

  Future<bool> socialMediaSignIn(String token) async {
    try {
      print('From sign in function ---->');
      signInLoading = true;
      signInErrorMsg = '';
      print('firebse Token------>$token');
      final response = await profileService.socialMediaSignIn(token);
      print('response----->${json.decode(response.body)}');
      if (response.statusCode == 200) {
        print('access token ----->${json.decode(response.body)}');
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(
            'aw_auth_token', json.decode(response.body)['token']['access']);
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
      signInLoading = false;
      signInErrorMsg = getErrorMsg(error);
      return false;
    }
  }




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