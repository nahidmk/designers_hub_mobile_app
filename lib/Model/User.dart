import '../Enum/Gender.dart';
import '../Enum/Provider.dart';
import 'package:designers_hub_modile_app/Model/Cart.dart';


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class User{
  final bool active;
  final String address;
  final bool banned;
  final DateTime dateOfBirth;
  final bool disabled;
  final String email;
  final String fullName;
  final Gender gender;
  final int id;
  final String nid;
  final String nidPictureBack;
  final String nidPictureFront;
  final String primaryNumber;
  final String profilePicture;
  final Provider provider;
  final String providerId;
  final String secondaryNumber;


  User({
      required this.active,
      required this.address,
      required this.banned,
      required this.dateOfBirth,
      required this.disabled,
      required this.email,
      required this.fullName,
      required this.gender,
      required this.id,
      required this.nid,
      required this.nidPictureBack,
      required this.nidPictureFront,
      required this.primaryNumber,
      required this.profilePicture,
      required this.provider,
      required this.providerId,
      required this.secondaryNumber,
      });


  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    email: json["email"],
    fullName: json["fullName"],
    profilePicture: json["profilePicture"],
    primaryNumber: json["primaryNumber"],
    secondaryNumber: json["secondaryNumber"],
    address: json["address"],
    gender: json["gender"],
    dateOfBirth: json["dateOfBirth"],
    provider: json["provider"],
    providerId: json["providerId"],
    active: json["active"],
    disabled: json["disabled"],
    banned: json["banned"],
    nid: json["nid"],
    nidPictureFront: json["nidPictureFront"],
    nidPictureBack: json["nidPictureBack"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "fullName": fullName,
    "profilePicture": profilePicture,
    "primaryNumber": primaryNumber,
    "secondaryNumber": secondaryNumber,
    "address": address,
    "gender": gender,
    "dateOfBirth": dateOfBirth,
    "provider": provider,
    "providerId": providerId,
    "active": active,
    "disabled": disabled,
    "banned": banned,
    "nid": nid,
    "nidPictureFront": nidPictureFront,
    "nidPictureBack": nidPictureBack,
  };
}