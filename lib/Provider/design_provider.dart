import 'dart:convert';

import 'package:designers_hub_modile_app/Model/design.dart';
import 'package:designers_hub_modile_app/Model/design_image.dart';
import 'package:designers_hub_modile_app/Model/design_type.dart';
import 'package:designers_hub_modile_app/Model/fabric.dart';
import 'package:designers_hub_modile_app/Model/fabric_mixing.dart';
import 'package:designers_hub_modile_app/Service/design_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

class DesignProvider extends ChangeNotifier {
  DesignService get designService => GetIt.I<DesignService>();

  bool _loadingList = true;

  List<Design> _designList = [];
  bool _loading = true;
  int _totalElements = 0;

  int _currentPage = 0;
  bool _loadingMore = false;

  int get currentPage => _currentPage;

  set currentPage(int value) {
    _currentPage = value;
    notifyListeners();
  }

  bool get loadingMore => _loadingMore;

  set loadingMore(bool value) {
    _loadingMore = value;
    notifyListeners();
  }

  int get totalElements => _totalElements;

  set totalElements(int value) {
    _totalElements = value;
    notifyListeners();
  }

  bool get loadingList => _loadingList;

  set loadingList(bool value) {
    _loadingList = value;
    notifyListeners();
  }

  Design _design = Design(
    id: 0,
    name: "name",
    price: 0,
    disabled: false,
    descriptions: 'descriptions',
    thumbnail: "",
    favCount: 0,
    fabrics: [
      new Fabric(
          available: false,
          baseColor: 'baseColor',
          descriptions: 'descriptions',
          disabled: false,
          favCount: 0,
          id: 0,
          name: 'name',
          price: 0,
          slug: 'slug',
          fabricMixings: [
            new FabricMixing(
                id: 0,
                percentage: 0,
                fabricMixingType: 'fabricMixingType',
                fabricWeave: 'fabricWeave'),
          ],
          thumbnail: 'thumbnail'),
    ],
    designType: DesignType(id: 0, requiredFabric: false, title: ""),
    designImages: [
      new DesignImage(id: 0, image: 'image'),
    ],
    // user: User(
    //     active: false,
    //     address: "address",
    //     banned: false,
    //     dateOfBirth: "dateOfBirth",
    //     disabled: false,
    //     email: "email",
    //     fullName: "fullName",
    //     gender: "gender",
    //     id: 0,
    //     nid: "nid",
    //     nidPictureBack: "nidPictureBack",
    //     nidPictureFront: "nidPictureFront",
    //     primaryNumber: 'primaryNumber',
    //     profilePicture: 'profilePicture',
    //     provider: 'provider',
    //     providerId: 'providerId',
    //     secondaryNumber: 'secondaryNumber'
    // )
  );

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

  Design get design => _design;

  set design(Design value) {
    _design = value;
    notifyListeners();
  }

  void getDesignList(
      {String designName = '',
      int page = 0,
      int size = 10,
      bool loadMore = false}) async {
    try {
      !loadMore ? loadingList = true : loadingMore = true;
      page = loadingMore ? currentPage : page;
      final response = await designService.getAllDesign(
          designName: designName, size: size, page: page);
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        designList = loadMore
            ? [
                ..._designList,
                ...(jsonResponse['content'] as List)
                    .map((e) => Design.fromJson(e))
                    .toList()
              ]
            : (jsonResponse['content'] as List)
                .map((e) => Design.fromJson(e))
                .toList();

        totalElements = json.decode(response.body)['totalElements'];
      } else {
        print('get design response error ---> ${json.decode(response.body)}');
      }
      !loadMore ? loadingList = false : loadingMore = false;
    } catch (error) {
      !loadMore ? loadingList = false : loadingMore = false;
      print('design gt error ---> $error');
    }
  }

  void getDesign(int id) async {
    try {
      loading = true;
      final response = await designService.getDesignById(id);
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        print("json response-->${jsonResponse['designImages']}");
        design = Design.fromJson(jsonResponse);

        print("Design name----->${_design.designImages}");
      } else {
        print('get design response error ---> ${json.decode(response.body)}');
      }
      loading = false;
    } catch (error) {
      loading = false;
      print('design gt error ---> $error');
    }
  }

  setCurrentPage(int page, bool __loadingMore) {
    if (!__loadingMore && currentPage > 0) {
      currentPage = page;
    }
    currentPage = currentPage + 1;
  }
}
