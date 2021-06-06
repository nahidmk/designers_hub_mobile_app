import '../../helper/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class design_service{

  Future <http.Response> getAllDesign() async => await http.get(
        Uri.parse(GET_ALL_DESIGN)
    );

}