import 'package:designers_hub_modile_app/Model/design.dart';

class HomepageDesignDetails{

   int id;
   int colSize;
   String image;
   Design design;

  HomepageDesignDetails({
     required this.id,
     required this.colSize,
     required this.image,
     required this.design,
  });

  factory HomepageDesignDetails.fromJson(Map<String, dynamic> json) {
    return HomepageDesignDetails(
    id: json["id"] as int,
    colSize: json["colSize"] as int,
    image: json["image"]==null?"":json["image"] as String,
    design: Design.fromJson(json['design'])
    );
}

  Map<String, dynamic> toJson() => {
    "id": id,
    "colSize":colSize,
    "image": image,
  };


}