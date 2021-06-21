import '../Model/fabric_mixing.dart';
import '../Model/user.dart';

class Fabric {

   bool available;
   String baseColor;
   String descriptions;
   bool disabled;
   int favCount;
   int id;
   String name;
   double price;
   String slug;
   String thumbnail;
   List<FabricMixing> fabricMixings;





  Fabric({
     required this.available,
     required this.baseColor,
     required this.descriptions,
     required this.disabled,
     required this.favCount,
     required this.id,
     required this.name,
     required this.price,
     required this.slug,
     required this.fabricMixings,
     required this.thumbnail,
  });

  factory Fabric.fromJson(Map<String, dynamic> json) => Fabric(
    id: json["id"] as int,
    name: json["name"]==null ? '':json["name"] as String,
    available: json["available"] as bool,
    baseColor: json["baseColor"] ==null?'':json["baseColor"] as String,
    slug: json["slug"]==null?'':json["slug"] as String,
    thumbnail: json["thumbnail"]==null?'':json["thumbnail"] as String,
    favCount: json["favCount"] as int,
    price: json["price"] as double,
    disabled: json["disabled"] as bool,
    descriptions: json["descriptions"]==null?'':json["descriptions"] as String,
    fabricMixings: json["fabricMixings"]==null?[]:List<FabricMixing>.from(json["fabricMixings"].map((x) => FabricMixing.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "available": available,
    "baseColor": baseColor,
    "slug": slug,
    "thumbnail": thumbnail,
    "favCount": favCount,
    "pricePerYard": price,
    "disabled": disabled,
    "descriptions": descriptions,
    "fabricMixings": List<dynamic>.from(fabricMixings.map((x) => x.toJson())),
  };


}