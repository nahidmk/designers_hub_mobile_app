
class Promo{
  String code;

  Promo({
    required this.code,
  });

  factory Promo.fromJson(Map<String, dynamic> json) => Promo(

      code: json["code"]==null? '':json["code"] as String,
  );

  Map<String, dynamic> toJson() => {
    "code": code,
  };



}