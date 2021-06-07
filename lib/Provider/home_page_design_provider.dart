

import 'dart:convert';

import 'package:designers_hub_modile_app/Model/home_page_design.dart';
import 'package:designers_hub_modile_app/Service/home_page_desing_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

class HomePageDesignProvider extends ChangeNotifier{

  HomePageDesignService get homePageDesignService => GetIt.I<HomePageDesignService>();

  List<HomePageDesign> _homePageDesignList = [];
  bool _loadingHomePageDesignList = true;
  int _totalElements = 0;


  List<HomePageDesign> get homePageDesignList => _homePageDesignList;

  set homePageDesignList(List<HomePageDesign> value) {
    _homePageDesignList = value;
    notifyListeners();
  }

  bool get loadingHomePageDesignList => _loadingHomePageDesignList;

  set loadingHomePageDesignList(bool value) {
    _loadingHomePageDesignList = value;
    notifyListeners();
  }

  int get totalElements => _totalElements;

  set totalElements(int value) {
    _totalElements = value;
    notifyListeners();
  }


  void getHomePageDesignList() async {
    try{
      loadingHomePageDesignList = true;
      final response = await homePageDesignService.getAllHomePageDesign();
      if(response.statusCode == 200){
        final jsonResponse = json.decode(response.body);
        print("status code....");
        print('json response ---> $jsonResponse');
        homePageDesignList = (jsonResponse['content'] as List).map(
                (e) => HomePageDesign.fromJson(e)
        ).toList();

        print('home page design --->${homePageDesignList[0].toJson()}');

        totalElements = jsonResponse['totalElements'];
      }else{
        print('get home page design response error ---> ${json.decode(response.body)}');
      }
      loadingHomePageDesignList = false;
    }catch(error){
      loadingHomePageDesignList = false;
      print('home page design get error ---> $error');
    }
  }


}