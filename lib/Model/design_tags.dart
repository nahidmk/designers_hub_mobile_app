import 'package:flutter/material.dart';

class DesignTag{



     int id;
     String title;




    DesignTag({
        required this.id,
        required this.title
    });


    factory DesignTag.fromJson(Map<String, dynamic> json) => DesignTag(
        id: json["id"] as int,
        title: json["title"] == null? '':json["title"] as String,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
    };
}
