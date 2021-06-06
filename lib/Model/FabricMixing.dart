

import '../Enum/FabricMixingtype.dart';
import '../Enum/FabricWeave.dart';

class FabricMixing{

  final int id;
  final double percentage;
  final FabricMixingType fabricMixingType;
  final FabricWeave fabricWeave;

  FabricMixing({
    required this.id,
    required this.percentage,
    required this.fabricMixingType,
    required this.fabricWeave});


  factory FabricMixing.fromJson(Map<String, dynamic> json) => FabricMixing(
    id: json["id"],
    fabricMixingType: json["fabricMixingType"],
    percentage: json["percentage"],
    fabricWeave: json["fabricWeave"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fabricMixingType": fabricMixingType,
    "percentage": percentage,
    "fabricWeave": fabricWeave,
  };
}