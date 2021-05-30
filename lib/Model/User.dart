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
  final String password;
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
      required this.password,
      required this.primaryNumber,
      required this.profilePicture,
      required this.provider,
      required this.providerId,
      required this.secondaryNumber,
      });
}