class User {
  bool active;
  String address;
  bool banned;
  String dateOfBirth;
  bool disabled;
  String email;
  String fullName;
  String gender;
  int id;
  String nid;
  String password;
  String nidPictureBack;
  String nidPictureFront;
  String primaryNumber;
  String profilePicture;
  String provider;
  String providerId;
  String secondaryNumber;

  User({
    required this.active,
    required this.address,
    required this.banned,
    required this.dateOfBirth,
    required this.disabled,
    required this.email,
    required this.fullName,
    required this.gender,
    required this.password,
    required this.id,
    required this.nid,
    required this.nidPictureBack,
    required this.nidPictureFront,
    required this.primaryNumber,
    required this.profilePicture,
    required this.provider,
    required this.providerId,
    required this.secondaryNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] as int,
        email: json["email"] == null ? '' : json["email"] as String,
        fullName: json["fullName"] == null ? '' : json["fullName"] as String,
        profilePicture: json["profilePicture"] == null
            ? ''
            : json["profilePicture"] as String,
        primaryNumber: json["primaryNumber"] == null
            ? ''
            : json["primaryNumber"] as String,
        secondaryNumber: json["secondaryNumber"] == null
            ? ''
            : json["secondaryNumber"] as String,
        address: json["address"] == null ? '' : json["address"] as String,
        gender: json["gender"] == null ? '' : json["gender"] as String,
        dateOfBirth: json["dateOfBirth"] == null ? "" : json["dateOfBirth"],
        provider: json["provider"] == null ? "" : json["provider"] as String,
        providerId:
            json["providerId"] == null ? '' : json["providerId"] as String,
        password: json["password"] == null ? '' : json["password"] as String,
        active: json["active"] as bool,
        disabled: json["disabled"] as bool,
        banned: json["banned"] as bool,
        nid: json["nid"] == null ? '' : json["providerId"] as String,
        nidPictureFront: json["nidPictureFront"] == null
            ? ''
            : json["nidPictureFront"] as String,
        nidPictureBack: json["nidPictureBack"] == null
            ? ''
            : json["nidPictureBack"] as String,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email.isEmpty ? null : email,
        "fullName": fullName.isEmpty ? null : fullName,
        "profilePicture": profilePicture.isEmpty ? null : profilePicture,
        "primaryNumber": primaryNumber.isEmpty ? null : primaryNumber,
        "secondaryNumber": secondaryNumber.isEmpty ? null : secondaryNumber,
        "address": address.isEmpty ? null : address,
        "gender": gender.isEmpty ? null : gender,
        "dateOfBirth": dateOfBirth.isEmpty ? null : dateOfBirth,
        "provider": provider.isEmpty ? null : provider,
        "providerId": providerId.isEmpty ? null : providerId,
        "active": active,
        "disabled": disabled,
        "password": password,
        "banned": banned,
        "nid": nid.isEmpty ? null : nid,
        "nidPictureFront": nidPictureFront.isEmpty ? null : nidPictureFront,
        "nidPictureBack": nidPictureBack.isEmpty ? null : nidPictureBack,
      };
}
