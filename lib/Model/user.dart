
class User{
  final bool active;
  final String address;
  final bool banned;
  final String dateOfBirth;
  final bool disabled;
  final String email;
  final String fullName;
  final String gender;
  final int id;
  final String nid;
  final String nidPictureBack;
  final String nidPictureFront;
  final String primaryNumber;
  final String profilePicture;
  final String provider;
  final String providerId;
  final String secondaryNumber;

  User({
      required this.active,
      required this.address,
      required this.banned,
      required this.dateOfBirth,
      required this.disabled,
      required this.email,
      required this.fullName,
      required this.gender,
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
    email: json["email"]==null?'':json["email"] as String,
    fullName: json["fullName"]==null?'':json["fullName"] as String,
    profilePicture: json["profilePicture"]==null ? '': json["profilePicture"] as String,
    primaryNumber: json["primaryNumber"] == null ? '':json["primaryNumber"]as String,
    secondaryNumber: json["secondaryNumber"] == null? '':json["secondaryNumber"]as String,
    address: json["address"]==null?'':json["address"]as String,
    gender: json["gender"] == null? "": json["gender"] as String,
    dateOfBirth: json["dateOfBirth"]==null ? "":json["dateOfBirth"],
    provider: json["provider"]==null? "":json["provider"]as String,
    providerId: json["providerId"] == null ? '':json["providerId"] as String,
    active: json["active"] as bool,
    disabled: json["disabled"] as bool,
    banned: json["banned"]as bool,
    nid: json["nid"]==null ? '':json["providerId"] as String,
    nidPictureFront: json["nidPictureFront"]==null? '':json["nidPictureFront"] as String,
    nidPictureBack: json["nidPictureBack"]==null ? '': json["nidPictureBack"] as String,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "fullName": fullName,
    "profilePicture": profilePicture,
    "primaryNumber": primaryNumber,
    "secondaryNumber": secondaryNumber,
    "address": address,
    "gender": gender,
    "dateOfBirth": dateOfBirth,
    "provider": provider,
    "providerId": providerId,
    "active": active,
    "disabled": disabled,
    "banned": banned,
    "nid": nid,
    "nidPictureFront": nidPictureFront,
    "nidPictureBack": nidPictureBack,
  };
}