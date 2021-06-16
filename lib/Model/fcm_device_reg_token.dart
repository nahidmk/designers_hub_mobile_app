
class FCMDeviceRegToken {
  int id;
  int userId;
  String registrationToken;

  FCMDeviceRegToken({  this.id=0, this.userId=0, required this.registrationToken});

  
  factory FCMDeviceRegToken.fromJson(Map<String, dynamic> json) => FCMDeviceRegToken(
    id: json["id"] as int,
    userId: json["userId"] as int,
    registrationToken: json["registrationToken"]==null ? '' :json["registrationToken"]  as String,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId":userId,
    "registrationToken":registrationToken
  };
}
