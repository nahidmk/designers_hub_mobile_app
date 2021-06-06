import 'package:flutter/material.dart';

class DesignTag{

    final int id;
    final String title;

    DesignTag({required this.id, required this.title});

    factory DesignTag.fromJson(Map<String, dynamic> json) => DesignTag(
        id: json["id"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
    };
}
