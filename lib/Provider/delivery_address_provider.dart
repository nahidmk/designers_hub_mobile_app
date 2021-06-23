
import 'dart:convert';
import 'dart:io';

import 'package:designers_hub_modile_app/Model/delivery_address.dart';
import 'package:designers_hub_modile_app/Service/delivery_address_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeliveryAddressProvider extends ChangeNotifier{

  DeliveryAddressService get deliveryAddressService => GetIt.I<DeliveryAddressService>();

  List<DeliveryAddress> _deliveryAddresses=[];
  bool _loadingDeliveryAddresses = true;
  String _deliveryAddressesErrorMsg = '';

  bool _loadingAddAddress = false;
  String _addAddressErrorMsg = '';

  bool _loadingDeleteAddress = false;
  String _deleteAddressErrorMsg = '';

  bool _popAbleScreen = false;

  DeliveryAddress _selectedDeliveryAddress = DeliveryAddress(id: 0, address: "", title: "", phoneNumber: "");

  DeliveryAddress get selectedDeliveryAddress => _selectedDeliveryAddress;

  set selectedDeliveryAddress(DeliveryAddress value) {
    _selectedDeliveryAddress = value;
    notifyListeners();
  }

  List<DeliveryAddress> get deliveryAddresses => _deliveryAddresses;

  set deliveryAddresses(List<DeliveryAddress> value) {
    _deliveryAddresses = value;
    notifyListeners();
  }

  bool get loadingDeliveryAddresses => _loadingDeliveryAddresses;

  set loadingDeliveryAddresses(bool value) {
    _loadingDeliveryAddresses = value;
    notifyListeners();
  }

  String get deliveryAddressesErrorMsg => _deliveryAddressesErrorMsg;

  set deliveryAddressesErrorMsg(String value) {
    _deliveryAddressesErrorMsg = value;
    notifyListeners();
  }

  bool get loadingAddAddress => _loadingAddAddress;

  set loadingAddAddress(bool value) {
    _loadingAddAddress = value;
    notifyListeners();
  }

  String get addAddressErrorMsg => _addAddressErrorMsg;

  set addAddressErrorMsg(String value) {
    _addAddressErrorMsg = value;
    notifyListeners();
  }

  bool get loadingDeleteAddress => _loadingDeleteAddress;

  set loadingDeleteAddress(bool value) {
    _loadingDeleteAddress = value;
    notifyListeners();
  }

  String get deleteAddressErrorMsg => _deleteAddressErrorMsg;

  set deleteAddressErrorMsg(String value) {
    _deleteAddressErrorMsg = value;
    notifyListeners();
  }

  bool get popAbleScreen => _popAbleScreen;

  set popAbleScreen(bool value) {
    _popAbleScreen = value;
    notifyListeners();
  }

  DeliveryAddressProvider(){
    _getSelectedDeliveryAddress();
  }


  _getSelectedDeliveryAddress() async {
    print('constructor called from delivery address provider ----------');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Object? addressString = prefs.get('delivery_address');
    if(addressString != null){
      DeliveryAddress deliveryAddress = DeliveryAddress.fromJson(json.decode(addressString.toString()));
      selectedDeliveryAddress = deliveryAddress;
    }
  }

  Future<List<DeliveryAddress>> getAllDeliveryAddresses() async {
    loadingDeliveryAddresses = true;
    deliveryAddressesErrorMsg = '';

    try{
      final response = await deliveryAddressService.fetchDeliveryAddresses();
      if(response.statusCode == 200){
        print('delivery address-> ${json.decode(response.body)}');

        _deliveryAddresses = (json.decode(response.body)['content'] as List)
            .map((e) => DeliveryAddress.fromJson(e)).toList();

        loadingDeliveryAddresses = false;
        return _deliveryAddresses;
      }else{
        loadingDeliveryAddresses=false;
        print('delivery address response error--->${response.body}');
        deliveryAddressesErrorMsg = 'Unexpected error !';
        return [];
      }

    }catch(error){
      loadingDeliveryAddresses=false;
      print('delivery address get error$error');
      deliveryAddressesErrorMsg = 'Unexpected error !';
    }
    return [];

  }


  Future<bool> createDeliveryAddress(DeliveryAddress deliveryAddress) async{
    loadingAddAddress = true;
    addAddressErrorMsg = '';

    try{
      final response = await deliveryAddressService.postDeliveryAddress(deliveryAddress);

      if(response.statusCode == 201){
        print('address created ${json.decode(response.body)}');
        DeliveryAddress newDeliveryAddress = DeliveryAddress.fromJson(json.decode(response.body));
        _deliveryAddresses.add(newDeliveryAddress);
        deliveryAddresses = _deliveryAddresses;
        loadingAddAddress = false;
        return true;
      }else{
        addAddressErrorMsg = json.decode(response.body)['message'];
        loadingAddAddress = false;
        print('delivery address post response error ${response.body}');
        return false;
      }
    }catch(error){
      loadingAddAddress = false;
      print('add address error-----> $error');
      addAddressErrorMsg = getErrorMsg(error);
      return false;
    }
  }

  Future<bool> updateDeliveryAddress(DeliveryAddress deliveryAddress) async{
    loadingAddAddress = true;
    addAddressErrorMsg = '';

    try{
      final response = await deliveryAddressService.updateDeliveryAddress(deliveryAddress);

      if(response.statusCode == 200){
        print('address updated ${json.decode(response.body)}');
        DeliveryAddress newDeliveryAddress = DeliveryAddress.fromJson(json.decode(response.body));
        deliveryAddresses = _deliveryAddresses.map((e){
          if(e.id == deliveryAddress.id){
            e = newDeliveryAddress;
          }
          return e;
        }).toList();
        if(selectedDeliveryAddress != null && deliveryAddress.id == selectedDeliveryAddress.id){
          selectedDeliveryAddress = newDeliveryAddress;
        }

        loadingAddAddress = false;
        return true;
      }else{
        addAddressErrorMsg = json.decode(response.body)['message'];
        loadingAddAddress = false;
        print('delivery address post response error ${response.body}');
        return false;
      }
    }catch(error){
      loadingAddAddress = false;
      print('update address error-----> $error');
      addAddressErrorMsg = getErrorMsg(error);
      return false;
    }
  }

  Future<bool> deleteDeliveryAddress(DeliveryAddress deliveryAddress) async{
    loadingDeleteAddress = true;
    deleteAddressErrorMsg = '';

    try{

      final response = await deliveryAddressService.deleteDeliveryAddress(deliveryAddress.id);

      if(response.statusCode == 200){
        print('address updated ${json.decode(response.body)}');
        _deliveryAddresses.removeWhere((element) => element.id == deliveryAddress.id);
        deliveryAddresses = _deliveryAddresses;

        if(selectedDeliveryAddress != null && deliveryAddress.id == selectedDeliveryAddress.id){
          selectedDeliveryAddress = DeliveryAddress(id: 0, address: "", title: "",  phoneNumber: "");;
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.remove('delivery_address');
        }

        loadingDeleteAddress = false;
        return true;
      }else{
        deleteAddressErrorMsg = 'can not delete address';
        loadingDeleteAddress = false;
        print('delivery address delete response error ${response.body}');
        return false;
      }
    }catch(error){
      loadingDeleteAddress = false;
      print('delete address error-----> $error');
      deleteAddressErrorMsg = 'Unexpected error !';
      return false;
    }
  }

  String getErrorMsg(error){
    if (error is SocketException) {
      return 'Please check your internet connection !';
    }
    else{
      return 'Something went wrong. Please try again later !';
    }
  }

}