import '../Model/FabricMixing.dart';
import '../Model/User.dart';

class Fabrics {

  final bool available;
  final String baseColor;
  final String descriptions;
  final bool disable;
  final int favCount;
  final int id;
  final String name;
  final double pricePerYard;
  final String slug;
  final String thumbnail;
  final List<FabricMixing> fabricMixing;
  final User user;

  Fabrics({
    required this.available,
    required this.baseColor,
    required this.descriptions,
    required this.disable,
    required this.favCount,
    required this.id,
    required this.name,
    required this.pricePerYard,
    required this.slug,
    required this.fabricMixing,
    required this.thumbnail,
    required this.user
  });


}