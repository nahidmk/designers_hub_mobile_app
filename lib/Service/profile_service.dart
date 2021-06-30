import 'dart:convert';

import 'package:designers_hub_modile_app/Model/user.dart';
import 'package:designers_hub_modile_app/helper/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class ProfileService {

  Future<http.Response> signIn(String username, String password) async {

    return http.post(
        Uri.parse(SIGN_IN_URL),
        headers: getHeader(),
        body:json.encode({"username":username, "password":password})
    );
  }


  Future<http.Response> isExistAccount(String phoneNumber) {
    return http.get(Uri.parse('$CHECK_PHONE_NUMBER?phoneNumber=$phoneNumber}'));
  }


  Future<http.Response> signUp(User user, String? token) async {
    return http.post(
        Uri.parse(SIGN_UP_URL),
        headers: {
          'Content-Type': 'application/json',
          'FIREBASE-TOKEN': token == null ? '' : token,
        },
        body:json.encode(user.toJson()));
  }

  Future<http.Response> socialMediaSignIn(String token) async {
    return http.post(
        Uri.parse(SOCIAL_MEDIA_SIGN_IN),
        headers: {
          'Content-Type': 'application/json',
          'FIREBASE-TOKEN': token,
        },
        body:null);
  }


  Future<http.Response> updateProfile(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? authToken = prefs.getString('aw_auth_token');

    user.dateOfBirth = (user.dateOfBirth != null ? "${user.dateOfBirth} 00:00:00" : null)!;

    print('user --------->${json.encode(user)}');

    return http.put(Uri.parse(UPDATE_PROFILE_URL),body:json.encode(user), headers: getAuthHeader(authToken));
  }


  Future<http.Response> getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? authToken = prefs.getString('aw_auth_token');

    return http.get(
        Uri.parse(GET_PROFILE_URL),
        headers: getAuthHeader(authToken)
    );
  }


  Map<String, String> getHeader() {

    Map<String , String> header = {
      'Content-Type': 'application/json',
    };

    return header;
  }


  Map<String, String> getAuthHeader(String? authToken) {

    Map<String , String> header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $authToken',
    };

    return header;
  }

}