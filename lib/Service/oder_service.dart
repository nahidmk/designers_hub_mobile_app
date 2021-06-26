
import 'dart:io';

import 'package:designers_hub_modile_app/Model/cart.dart';
import 'package:designers_hub_modile_app/Model/delivery_address.dart';
import 'package:designers_hub_modile_app/helper/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:http/http.dart' as Http;

class OrderService {

  Future<Http.Response> updateCart(Cart cart) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    return Http.put(
      Uri.parse("$CART_UPDATE"),
      body: json.encode(cart),
      headers: getAuthHeader(sharedPreferences.get("aw_auth_token").toString())
    );
  }

  Future<Http.Response> placeOrder(DeliveryAddress deliveryAddress) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    return Http.post(
        Uri.parse("$PLACE_ORDER"),
        body: json.encode({
          "deliveryAddress" : deliveryAddress.toJson(),
          "paymentType": "CASH_ON_DELIVERY"
        }),
        headers: getAuthHeader(sharedPreferences.get("aw_auth_token").toString())
    );
  }

  Future<Http.Response> getAllOrder(int page, int size) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    return Http.get(
      Uri.parse("$GET_ALL_ORDER?page=$page&size=$size"),
      headers: getAuthHeader(
        sharedPreferences.get("aw_auth_token").toString(),
      ),
    );
  }


  Future<Http.Response> getOrderByOrderId(int orderId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    return Http.get(
      Uri.parse("$GET_ORDER_BY_ID/$orderId"),
      headers: getAuthHeader(
        sharedPreferences.get("os_auth_token").toString(),
      ),
    );
  }


  Map<String, String> getAuthHeader(String? authToken) {

    Map<String , String> header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $authToken',
    };

    return header;
  }
}