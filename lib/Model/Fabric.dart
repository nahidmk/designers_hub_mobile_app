import '../Model/FabricMixing.dart';
import '../Model/User.dart';

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
    id: json["id"],
    name: json["name"],
    available: json["available"],
    baseColor: json["baseColor"],
    slug: json["slug"],
    thumbnail: json["thumbnail"],
    favCount: json["favCount"],
    pricePerYard: json["pricePerYard"],
    disabled: json["disabled"],
    descriptions: json["descriptions"],
    fabricMixings: List<FabricMixing>.from(json["fabricMixings"].map((x) => FabricMixing.fromJson(x))),
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