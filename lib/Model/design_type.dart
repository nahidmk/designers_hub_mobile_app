class DesignType {

  final int id;
  final bool requiredFabric;
  final String title;

  DesignType({required this.id, required this.requiredFabric,required this.title});


  factory DesignType.fromJson(Map<String, dynamic> json) => DesignType(

      id: json["id"] as int,
      requiredFabric: json["requiredFabric"] as bool,
      title: json["title"]==null? " ":json['title'] as String,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "requiredFabric":requiredFabric,
    "title":title

  };
}