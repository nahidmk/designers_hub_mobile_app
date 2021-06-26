class OrderStatus{

  String name;
  String value;

  OrderStatus({ required this.name, required this.value});

  factory OrderStatus.fromJson(Map<String, dynamic> json) => OrderStatus(


    name: json["name"]==null? " ":json['name'] as String,
    value: json["value"]==null? " ":json['value'] as String,


  );

  Map<String, dynamic> toJson() => {

    "name":name,
    "value":value

  };
}