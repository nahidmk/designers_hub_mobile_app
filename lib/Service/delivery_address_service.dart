import 'dart:convert';

import 'package:designers_hub_modile_app/Model/delivery_address.dart';
import 'package:designers_hub_modile_app/helper/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DeliveryAddressService{

  Future<http.Response> fetchDeliveryAddresses() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? authToken = prefs.getString('aw_auth_token');

    return http.get(Uri.parse('$GET_ALL_DELIVERY_ADDRESSES'), headers: getAuthHeader(authToken));
  }

  Future<http.Response> postDeliveryAddress(DeliveryAddress deliveryAddress) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? authToken = prefs.getString('aw_auth_token');

    return http.post(Uri.parse(POST_DELIVERY_ADDRESS),body: json.encode(deliveryAddress), headers: getAuthHeader(authToken));
  }

  Future<http.Response> updateDeliveryAddress(DeliveryAddress deliveryAddress) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? authToken = prefs.getString('aw_auth_token');

    return http.put(Uri.parse('$UPDATE_DELIVERY_ADDRESS/${deliveryAddress.id}'),body: json.encode(deliveryAddress), headers: getAuthHeader(authToken));
  }

  Future<http.Response> deleteDeliveryAddress(int id) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? authToken = prefs.getString('aw_auth_token');

    return http.delete(Uri.parse('$DELETE_DELIVERY_ADDRESS/$id'), headers: getAuthHeader(authToken));
  }

  Map<String, String> getAuthHeader(String? authToken) {

    Map<String , String> header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $authToken',
    };

    return header;
  }

}
