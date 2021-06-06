

class DesignImage{
  final int id;
  final String image;

  DesignImage({ required this.id, required this.image});

  factory DesignImage.fromJson(Map<String, dynamic> json) => DesignImage(
    id: json["id"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
  };
}