class PaymentType{

  String name;
  String value;

  PaymentType({ required this.name, required this.value});

  factory PaymentType.fromJson(Map<String, dynamic> json) => PaymentType(

    name: json["name"]==null? " ":json['name'] as String,
    value: json["value"]==null? " ":json['value'] as String,

  );
  Map<String, dynamic> toJson() => {

    "name":name,
    "value":value

  };
}