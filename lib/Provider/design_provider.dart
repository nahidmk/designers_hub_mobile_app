import 'dart:convert';

import 'package:designers_hub_modile_app/Model/design.dart';
import 'package:designers_hub_modile_app/Service/design_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

class DesignProvider extends ChangeNotifier {

  DesignService get designService => GetIt.I<DesignService>();

  List<Design> _designList = [];
  bool _loading = true;
  int _totalElements = 0;
  dynamic _design;


  List<Design> get designList => _designList;

  set designList(List<Design> value) {
    _designList = value;
    notifyListeners();
  }

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  int get totalElements => _totalElements;

  set totalElements(int value) {
    _totalElements = value;
    notifyListeners();
  }

  Design get design => _design;

  set design(Design value) {
    _design = value;
    notifyListeners();
  }


  void getDesignList() async {
    try {
      loading = true;
      final response = await designService.getAllDesign();
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        designList = (jsonResponse['content'] as List).map(
                (e) => Design.fromJson(e)
        ).toList();
      } else {
        print('get design response error ---> ${json.decode(response.body)}');
      }
      loading = false;
    } catch (error) {
      loading = false;
      print('design gt error ---> $error');
    }
  }


  void getDesign(int id) async {
    try {
      loading = true;
      final response = await designService.getDesignById(id);
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        print('json response ---> $jsonResponse');

        design = Design.fromJson(jsonResponse);

        print("Design name----->${_design.name}");

      } else {
        print('get design response error ---> ${json.decode(response.body)}');
      }
      loading = false;
    } catch (error) {
      loading = false;
      print('design gt error ---> $error');
    }
  }


}

