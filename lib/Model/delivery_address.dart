
class DeliveryAddress{

   int id;
   String address;
   String title;
   String phoneNumber;

  DeliveryAddress({
      required this.id,
      required this.address,
      required this.title,
      required this.phoneNumber
      });

  factory DeliveryAddress.fromJson(Map<String, dynamic> json) => DeliveryAddress(

    id: json["id"] as int,
    address: json["address"]==null?"":json["address"] as String,
    title: json["title"]==null? " ":json['title'] as String,
    phoneNumber: json["phoneNumber"]==null? " ":json['phoneNumber'] as String,


  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "address":address,
    "title":title,
    "phoneNumber":phoneNumber,
  };
}