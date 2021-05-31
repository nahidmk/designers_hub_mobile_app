import 'dart:convert';

import 'package:designers_hub_modile_app/Model/DemoUser.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


class FetchData extends StatefulWidget {

  @override
  _FetchDataState createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> {

  Future getData() async{
    var response = await http.get(Uri.http("jsonplaceholder.typecode.com", "users"));
    var jsonData = jsonDecode(response.body);
    List<DemoUser> users = [];

    for(var u in jsonData){
      users.add(new DemoUser(u['name'], u['email'], u['username']));
    }
    print(users.length);
    return users;

  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

