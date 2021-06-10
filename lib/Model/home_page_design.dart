
import 'package:designers_hub_modile_app/Model/home_page_design_details.dart';

class HomePageDesign{

   int id;
   int height;
   String title;
   List<HomepageDesignDetails> homePageDesignDetailsList;

  HomePageDesign({
    required this.id,
    required this.height,
    required this.title,
    required this.homePageDesignDetailsList
  });

  factory HomePageDesign.fromJson(Map<String, dynamic> json) {
    return HomePageDesign(
        id: json["id"] as int,
        height: json["height"] as int,
        title: json["title"]==null?"":json["title"] as String,
        homePageDesignDetailsList: json["homepageDesignDetails"]==null? []: List<HomepageDesignDetails>.from(json["homepageDesignDetails"].map((x) => HomepageDesignDetails.fromJson(x)))
        // (json['homepageDesignDetails'] as List)
        // .map((e) => HomepageDesignDetails.fromJson(e))
        // .toList()
  );
}

  Map<String, dynamic> toJson() => {
    "id": id,
    "height":height,
    "title": title,
    "homePageDesignDetails":homePageDesignDetailsList
  };
  
}