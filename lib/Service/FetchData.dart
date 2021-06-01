import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FetchData extends StatefulWidget {
@override
FetchDataState createState() => new FetchDataState();
}

class FetchDataState extends State<FetchData> {

  // List data=[];
  // Future <String> getData() async {
  //   var response = await http.get(
  //       // Uri.https("13.82.95.231","/api/v/1.0.0/public/designs"),
  //       // Uri.https("jsonplaceholder.typicode.com","posts"),
  //       Uri.https("protocoderspoint.com","jsondata/superheros.json"),
  //       headers: {
  //         "Accept": "application/json"
  //       }
  //   );
  //
  //   this.setState(() {
  //     data = jsonDecode(response.body);
  //   });
  //
  //   print(data.length);
  //
  //   return "Success!";
  // }


  List superheros_length=[];
  void getData() async {
    http.Response response =
    await http.get(
           // Uri.https("13.82.95.231","/api/v/1.0.0/public/designs"),
            Uri.https("jsonplaceholder.typicode.com","posts"),
        // Uri.https("protocoderspoint.com","jsondata/superheros.json")
    );
    if (response.statusCode == 200) {
      var data = response.body; //store response as string

      setState(() {
        superheros_length = jsonDecode(data); //get all the data from json string superheros
        print(superheros_length.length); // just printed length of data
      });


    } else {
      print(response.statusCode);
    }
  }


  @override
  Widget build(BuildContext context){
    return Container(
      child: superheros_length.length==0?Container(child: MaterialButton(
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
              children: superheros_length.map((e) {
              return Card(
              // child: Text(e["user"]["name"]),
              child: Text(e["title"]),
              // child: Text(e["name"]),
            );
        }).toList(),
      ),
          ),
      // :Text('hello'),
    );
  }
}
