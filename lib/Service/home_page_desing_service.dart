import 'package:designers_hub_modile_app/helper/constants.dart';


import 'package:http/http.dart' as http;
import 'dart:async';

class HomePageDesignService{

  Future <http.Response> getAllHomePageDesign({int page = 0, int size = 10}) {
    return http.get(Uri.parse('$GET_ALL_HOME_PAGE_DESIGN?page=$page&size=$size'));
  }

}