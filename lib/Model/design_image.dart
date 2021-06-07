

class DesignImage{



  final int id;
  final String image;




  DesignImage({ required this.id, required this.image});

  factory DesignImage.fromJson(Map<String, dynamic> json) => DesignImage(
    id: json["id"] as int,
    image: json["image"]==null? '':json["image"] as String,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
  };
}