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


  Future<http.Response> signUp(User user, String token) async {
    return http.post(
        Uri.parse(SIGN_UP_URL),
        headers: {
          'Content-Type': 'application/json',
          'FIREBASE-TOKEN': token,
        },
        body:json.encode(user.toJson()));
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