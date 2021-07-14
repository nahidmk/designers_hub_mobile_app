

import 'package:designers_hub_modile_app/helper/constants.dart';

import 'package:http/http.dart' as http;
import 'dart:async';

class DesignService{

  Future <http.Response> getAllDesign({String designName='',int page=0,int size=10}) {

    return http.get(Uri.parse('$GET_ALL_DESIGN?name=$designName&page=$page&size=$size&userId=0'));
  }


  Future <http.Response> getDesignById(int id) {
    return http.get(Uri.parse('$GET_DESIGN_BY_ID$id'));
  }

}