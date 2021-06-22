
class DeliveryAddress{

  final  int id;
  final String address;
  final String title;
  final bool preDefine;
  final bool disable;
  final String phoneNumber;

  DeliveryAddress({
      required this.id,
      required this.address,
      required this.title,
      required this.preDefine,
      required this.disable,
      required this.phoneNumber
      });

  factory DeliveryAddress.fromJson(Map<String, dynamic> json) => DeliveryAddress(

    id: json["id"] as int,
    address: json["address"]==null?"":json["address"] as String,
    title: json["title"]==null? " ":json['title'] as String,
    phoneNumber: json["phoneNumber"]==null? " ":json['phoneNumber'] as String,
    preDefine: json["preDefine"] as bool,
    disable: json["disable"] as bool

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "address":address,
    "title":title,
    "phoneNumber":phoneNumber,
    "preDefine":preDefine,
    "disable":disable

  };
}