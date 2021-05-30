

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
}