

import 'dart:convert';


import 'package:designers_hub_modile_app/Service/design_service.dart';

import '../dummy_model/album.dart';

import 'package:flutter/material.dart';


class FetchData extends StatefulWidget {

  @override
  _FetchDataState createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> {
  List<Album> _albumList=[];

  var service = design_service();

  void getData()async{

    var response = await service.getAllDesign();

    print("response code---->${response.statusCode}");

    // service.getAllAlbum().then((value) {
    //   if(value.statusCode==200){
    //     Iterable jsonData = json.decode(value.body);
    //     setState(() {
    //       _albumList = jsonData.map((i) => Album.fromJson(i)).toList();
    //       print(_albumList.length);
    //     });
    //   }
    // });
  }


  @override
  Widget build(BuildContext context) {
    return _albumList.length == 0
          ? Container(
      alignment: Alignment.bottomRight,
        margin: EdgeInsets.only(right: 10),
        child: MaterialButton(
          onPressed: getData,
          color: Colors.blue,
          elevation: 10.0,
          highlightElevation: 30.0,
          child: Text(
            'ADD',
            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600),
          ),
        ),
      ) : Container(
          height: 300,
          child: ListView(
            children: _albumList.map((e) {
              return Card(
                child: Text(e.title),
                // child: Text(e["name"]),
              );
            }).toList(),
          ),
      );
  }
}


