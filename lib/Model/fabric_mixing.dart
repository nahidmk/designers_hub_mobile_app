



class FabricMixing{


   int id;
   double percentage;
   String fabricMixingType;
   String fabricWeave;




  FabricMixing({
     required this.id,
     required this.percentage,
     required this.fabricMixingType,
     required this.fabricWeave});


  factory FabricMixing.fromJson(Map<String, dynamic> json) => FabricMixing(
    id: json["id"] as int,
    fabricMixingType: json["fabricMixingType"] ==null ? '' : json["fabricMixingType"] as String,
    percentage: json["percentage"]==null? 0.0 : json["percentage"] as double,
    fabricWeave: json["fabricWeave"]==null ? '' :json["fabricWeave"]  as String,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fabricMixingType": fabricMixingType,
    "percentage": percentage,
    "fabricWeave": fabricWeave,
  };
}