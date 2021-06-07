

import '../../helper/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class DesignService{

  Future <http.Response> getAllDesign() {
    return http.get(Uri.parse(GET_ALL_DESIGN));
  }

}