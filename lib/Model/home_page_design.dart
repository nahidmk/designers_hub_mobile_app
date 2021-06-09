
import 'package:designers_hub_modile_app/Model/home_page_design_details.dart';

class HomePageDesign{

  final int id;
  final int height;
  final String title;
  final List<HomepageDesignDetails> homePageDesignDetailsList;

  HomePageDesign({
    this.id=0,
     this.height=0,
     this.title='',
     this.homePageDesignDetailsList=0
  });

  factory HomePageDesign.fromJson(Map<String, dynamic> json) {
    return HomePageDesign(
        id: json["id"] as int,
        height: json["height"] as int,
        title: json["title"]==null?"":json["title"] as String,
        homePageDesignDetailsList: json["homepageDesignDetails"]==null? []:
        (json['homepageDesignDetails'] as List)
        .map((e) => HomepageDesignDetails.fromJson(e))
        .toList()
  );
}

  Map<String, dynamic> toJson() => {
    "id": id,
    "height":height,
    "title": title,
    "homePageDesignDetails":homePageDesignDetailsList
  };
  
}