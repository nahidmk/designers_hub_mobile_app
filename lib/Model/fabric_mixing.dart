



class FabricMixing{





  final int id;
  final double percentage;
  final String fabricMixingType;
  final String fabricWeave;




  FabricMixing({
     this.id=0,
     this.percentage=0,
     this.fabricMixingType='',
     this.fabricWeave=''});


  factory FabricMixing.fromJson(Map<String, dynamic> json) => FabricMixing(
    id: json["id"] as int,
    fabricMixingType: json["fabricMixingType"] ==null ? '' : json["fabricMixingType"] as String,
    percentage: json["percentage"] as double,
    fabricWeave: json["fabricWeave"]==null ? '' :json["fabricWeave"]  as String,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fabricMixingType": fabricMixingType,
    "percentage": percentage,
    "fabricWeave": fabricWeave,
  };
}