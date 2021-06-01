import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FetchData extends StatefulWidget {
@override
FetchDataState createState() => new FetchDataState();
}

class FetchDataState extends State<FetchData> {

  List data=[];

  Future getData() async {
    var response = await http.get(
        Uri.https("jsonplaceholder.typicode.com","posts"),
        headers: {
          "Accept": "application/json"
        }
    );

    this.setState(() {
      data = jsonDecode(response.body);
    });

    print(data.length);

    return "Success!";
  }

  // @override
  // void initState(){
  //   this.getData();
  // }

  @override
  Widget build(BuildContext context){
    return Container(
      child: data.length==0?Container(child: MaterialButton(
        onPressed: getData,
        color: Colors.blue,
        elevation: 10.0,
        highlightElevation: 30.0,
        child: Text(
            'Click me',
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w600
          ),
        ),
      ),)
          :Container(
            height: 300,
            child: ListView(
              children: data.map((e) {
              return Card(
              child: Text(e["title"]),
            );
        }).toList(),
      ),
          ),
      // :Text('hello'),
    );
  }
}
