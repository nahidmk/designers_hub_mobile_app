import '../Model/fabric_mixing.dart';
import '../Model/user.dart';

class Fabric {

  final bool available;
  final String baseColor;
  final String descriptions;
  final bool disabled;
  final int favCount;
  final int id;
  final String name;
  final double pricePerYard;
  final String slug;
  final String thumbnail;
  final List<FabricMixing> fabricMixings;





  Fabric({
    required this.available,
    required this.baseColor,
    required this.descriptions,
    required this.disabled,
    required this.favCount,
    required this.id,
    required this.name,
    required this.pricePerYard,
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
    pricePerYard: json["pricePerYard"] as double,
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
    "pricePerYard": pricePerYard,
    "disabled": disabled,
    "descriptions": descriptions,
    "fabricMixings": List<dynamic>.from(fabricMixings.map((x) => x.toJson())),
  };


}