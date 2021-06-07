

import 'dart:convert';

import 'package:designers_hub_modile_app/Model/design.dart';
import 'package:designers_hub_modile_app/Service/design_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

class DesignProvider extends ChangeNotifier {

  DesignService get designService => GetIt.I<DesignService>();

  List<Design> _designList = [];
  bool _loadingDesignList = true;
  int _totalElements = 0;

  List<Design> get designList => _designList;

  set designList(List<Design> value) {
    _designList = value;
    notifyListeners();
  }

  bool get loadingDesignList => _loadingDesignList;

  set loadingDesignList(bool value) {
    _loadingDesignList = value;
    notifyListeners();
  }

  int get totalElements => _totalElements;

  set totalElements(int value) {
    _totalElements = value;
    notifyListeners();
  }

  void getDesignList() async {
    try{
      loadingDesignList = true;
      final response = await designService.getAllDesign();
      if(response.statusCode == 200){
        final jsonResponse = json.decode(response.body);
        print("status code....");
        print('json response ---> $jsonResponse');
        designList = (jsonResponse['content'] as List).map(
          (e) => Design.fromJson(e)
        ).toList();

        totalElements = jsonResponse['totalElements'];
      }else{
        print('get design response error ---> ${json.decode(response.body)}');
      }
      loadingDesignList = false;
    }catch(error){
      loadingDesignList = false;
      print('design gt error ---> $error');
    }
  }

}