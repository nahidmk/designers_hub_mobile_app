// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  Product({
    this.id,
    this.name,
    this.slug,
    this.thumbnail,
    this.favCount,
    this.disabled,
    this.descriptions,
    this.price,
    this.designImages,
    this.tags,
    this.fabrics,
    this.user,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    this.available,
    this.baseColor,
    this.pricePerYard,
    this.fabricMixings,
  });

  int id;
  String name;
  String slug;
  String thumbnail;
  int favCount;
  bool disabled;
  String descriptions;
  int price;
  List<DesignImage> designImages;
  List<Tag> tags;
  List<Product> fabrics;
  User user;
  String createdAt;
  String updatedAt;
  int createdBy;
  int updatedBy;
  bool available;
  String baseColor;
  int pricePerYard;
  List<FabricMixing> fabricMixings;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    slug: json["slug"] == null ? null : json["slug"],
    thumbnail: json["thumbnail"],
    favCount: json["favCount"],
    disabled: json["disabled"],
    descriptions: json["descriptions"] == null ? null : json["descriptions"],
    price: json["price"] == null ? null : json["price"],
    designImages: json["designImages"] == null ? null : List<DesignImage>.from(json["designImages"].map((x) => DesignImage.fromJson(x))),
    tags: json["tags"] == null ? null : List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
    fabrics: json["fabrics"] == null ? null : List<Product>.from(json["fabrics"].map((x) => Product.fromJson(x))),
    user: User.fromJson(json["user"]),
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
    createdBy: json["createdBy"],
    updatedBy: json["updatedBy"],
    available: json["available"] == null ? null : json["available"],
    baseColor: json["baseColor"] == null ? null : json["baseColor"],
    pricePerYard: json["pricePerYard"] == null ? null : json["pricePerYard"],
    fabricMixings: json["fabricMixings"] == null ? null : List<FabricMixing>.from(json["fabricMixings"].map((x) => FabricMixing.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug == null ? null : slug,
    "thumbnail": thumbnail,
    "favCount": favCount,
    "disabled": disabled,
    "descriptions": descriptions == null ? null : descriptions,
    "price": price == null ? null : price,
    "designImages": designImages == null ? null : List<dynamic>.from(designImages.map((x) => x.toJson())),
    "tags": tags == null ? null : List<dynamic>.from(tags.map((x) => x.toJson())),
    "fabrics": fabrics == null ? null : List<dynamic>.from(fabrics.map((x) => x.toJson())),
    "user": user.toJson(),
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "createdBy": createdBy,
    "updatedBy": updatedBy,
    "available": available == null ? null : available,
    "baseColor": baseColor == null ? null : baseColor,
    "pricePerYard": pricePerYard == null ? null : pricePerYard,
    "fabricMixings": fabricMixings == null ? null : List<dynamic>.from(fabricMixings.map((x) => x.toJson())),
  };
}

class DesignImage {
  DesignImage({
    this.id,
    this.image,
  });

  int id;
  String image;

  factory DesignImage.fromJson(Map<String, dynamic> json) => DesignImage(
    id: json["id"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
  };
}

class FabricMixing {
  FabricMixing({
    this.id,
    this.fabricMixingType,
    this.percentage,
    this.fabricWeave,
  });

  int id;
  String fabricMixingType;
  int percentage;
  String fabricWeave;

  factory FabricMixing.fromJson(Map<String, dynamic> json) => FabricMixing(
    id: json["id"],
    fabricMixingType: json["fabricMixingType"],
    percentage: json["percentage"],
    fabricWeave: json["fabricWeave"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fabricMixingType": fabricMixingType,
    "percentage": percentage,
    "fabricWeave": fabricWeave,
  };
}

class Tag {
  Tag({
    this.id,
    this.title,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    this.alias,
  });

  int id;
  String title;
  CreatedAt createdAt;
  String updatedAt;
  int createdBy;
  int updatedBy;
  String alias;

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
    id: json["id"],
    title: json["title"] == null ? null : json["title"],
    createdAt: createdAtValues.map[json["createdAt"]],
    updatedAt: json["updatedAt"] == null ? null : json["updatedAt"],
    createdBy: json["createdBy"],
    updatedBy: json["updatedBy"],
    alias: json["alias"] == null ? null : json["alias"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title == null ? null : title,
    "createdAt": createdAtValues.reverse[createdAt],
    "updatedAt": updatedAt == null ? null : updatedAt,
    "createdBy": createdBy,
    "updatedBy": updatedBy,
    "alias": alias == null ? null : alias,
  };
}

enum CreatedAt { THE_21052021154624, THE_22052021125631, THE_24052021205059, THE_21052021112416 }

final createdAtValues = EnumValues({
  "21-05-2021 11:24:16": CreatedAt.THE_21052021112416,
  "21-05-2021 15:46:24": CreatedAt.THE_21052021154624,
  "22-05-2021 12:56:31": CreatedAt.THE_22052021125631,
  "24-05-2021 20:50:59": CreatedAt.THE_24052021205059
});

class User {
  User({
    this.id,
    this.email,
    this.fullName,
    this.profilePicture,
    this.primaryNumber,
    this.secondaryNumber,
    this.address,
    this.gender,
    this.dateOfBirth,
    this.provider,
    this.providerId,
    this.active,
    this.disabled,
    this.banned,
    this.emailVerified,
    this.phoneVerified,
    this.nid,
    this.nidPictureFront,
    this.nidPictureBack,
    this.nidVerified,
    this.roles,
    this.cart,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
  });

  int id;
  String email;
  String fullName;
  String profilePicture;
  String primaryNumber;
  dynamic secondaryNumber;
  String address;
  String gender;
  dynamic dateOfBirth;
  dynamic provider;
  dynamic providerId;
  bool active;
  bool disabled;
  bool banned;
  bool emailVerified;
  bool phoneVerified;
  dynamic nid;
  dynamic nidPictureFront;
  dynamic nidPictureBack;
  bool nidVerified;
  List<Tag> roles;
  Cart cart;
  CreatedAt createdAt;
  String updatedAt;
  int createdBy;
  int updatedBy;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    email: json["email"],
    fullName: json["fullName"],
    profilePicture: json["profilePicture"],
    primaryNumber: json["primaryNumber"],
    secondaryNumber: json["secondaryNumber"],
    address: json["address"],
    gender: json["gender"],
    dateOfBirth: json["dateOfBirth"],
    provider: json["provider"],
    providerId: json["providerId"],
    active: json["active"],
    disabled: json["disabled"],
    banned: json["banned"],
    emailVerified: json["emailVerified"],
    phoneVerified: json["phoneVerified"],
    nid: json["nid"],
    nidPictureFront: json["nidPictureFront"],
    nidPictureBack: json["nidPictureBack"],
    nidVerified: json["nidVerified"],
    roles: List<Tag>.from(json["roles"].map((x) => Tag.fromJson(x))),
    cart: Cart.fromJson(json["cart"]),
    createdAt: createdAtValues.map[json["createdAt"]],
    updatedAt: json["updatedAt"],
    createdBy: json["createdBy"],
    updatedBy: json["updatedBy"],
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
    "emailVerified": emailVerified,
    "phoneVerified": phoneVerified,
    "nid": nid,
    "nidPictureFront": nidPictureFront,
    "nidPictureBack": nidPictureBack,
    "nidVerified": nidVerified,
    "roles": List<dynamic>.from(roles.map((x) => x.toJson())),
    "cart": cart.toJson(),
    "createdAt": createdAtValues.reverse[createdAt],
    "updatedAt": updatedAt,
    "createdBy": createdBy,
    "updatedBy": updatedBy,
  };
}

class Cart {
  Cart({
    this.id,
    this.totalProducts,
    this.totalPrice,
    this.grandTotal,
    this.printingCost,
    this.finalPrice,
    this.cartDetailsList,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
  });

  int id;
  int totalProducts;
  int totalPrice;
  int grandTotal;
  int printingCost;
  int finalPrice;
  List<CartDetailsList> cartDetailsList;
  String createdAt;
  String updatedAt;
  int createdBy;
  int updatedBy;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
    id: json["id"],
    totalProducts: json["totalProducts"],
    totalPrice: json["totalPrice"],
    grandTotal: json["grandTotal"],
    printingCost: json["printingCost"],
    finalPrice: json["finalPrice"],
    cartDetailsList: List<CartDetailsList>.from(json["cartDetailsList"].map((x) => CartDetailsList.fromJson(x))),
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
    createdBy: json["createdBy"],
    updatedBy: json["updatedBy"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "totalProducts": totalProducts,
    "totalPrice": totalPrice,
    "grandTotal": grandTotal,
    "printingCost": printingCost,
    "finalPrice": finalPrice,
    "cartDetailsList": List<dynamic>.from(cartDetailsList.map((x) => x.toJson())),
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "createdBy": createdBy,
    "updatedBy": updatedBy,
  };
}

class CartDetailsList {
  CartDetailsList({
    this.id,
    this.fabricQuantity,
    this.pricePerYardFabric,
    this.designPrice,
    this.totalPrice,
    this.note,
    this.fabric,
    this.design,
  });

  int id;
  int fabricQuantity;
  int pricePerYardFabric;
  int designPrice;
  int totalPrice;
  dynamic note;
  Fabric fabric;
  Design design;

  factory CartDetailsList.fromJson(Map<String, dynamic> json) => CartDetailsList(
    id: json["id"],
    fabricQuantity: json["fabricQuantity"],
    pricePerYardFabric: json["pricePerYardFabric"],
    designPrice: json["designPrice"],
    totalPrice: json["totalPrice"],
    note: json["note"],
    fabric: Fabric.fromJson(json["fabric"]),
    design: Design.fromJson(json["design"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fabricQuantity": fabricQuantity,
    "pricePerYardFabric": pricePerYardFabric,
    "designPrice": designPrice,
    "totalPrice": totalPrice,
    "note": note,
    "fabric": fabric.toJson(),
    "design": design.toJson(),
  };
}

class Design {
  Design({
    this.id,
    this.name,
    this.slug,
    this.thumbnail,
    this.favCount,
    this.disabled,
    this.descriptions,
    this.price,
    this.designImages,
    this.tags,
  });

  int id;
  String name;
  dynamic slug;
  String thumbnail;
  int favCount;
  bool disabled;
  dynamic descriptions;
  int price;
  List<DesignImage> designImages;
  List<Tag> tags;

  factory Design.fromJson(Map<String, dynamic> json) => Design(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    thumbnail: json["thumbnail"],
    favCount: json["favCount"],
    disabled: json["disabled"],
    descriptions: json["descriptions"],
    price: json["price"],
    designImages: List<DesignImage>.from(json["designImages"].map((x) => DesignImage.fromJson(x))),
    tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "thumbnail": thumbnail,
    "favCount": favCount,
    "disabled": disabled,
    "descriptions": descriptions,
    "price": price,
    "designImages": List<dynamic>.from(designImages.map((x) => x.toJson())),
    "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
  };
}

class Fabric {
  Fabric({
    this.id,
    this.name,
    this.available,
    this.baseColor,
    this.slug,
    this.thumbnail,
    this.favCount,
    this.pricePerYard,
    this.disabled,
    this.descriptions,
    this.fabricMixings,
  });

  int id;
  String name;
  bool available;
  String baseColor;
  String slug;
  String thumbnail;
  int favCount;
  int pricePerYard;
  bool disabled;
  dynamic descriptions;
  List<FabricMixing> fabricMixings;

  factory Fabric.fromJson(Map<String, dynamic> json) => Fabric(
    id: json["id"],
    name: json["name"],
    available: json["available"],
    baseColor: json["baseColor"],
    slug: json["slug"],
    thumbnail: json["thumbnail"],
    favCount: json["favCount"],
    pricePerYard: json["pricePerYard"],
    disabled: json["disabled"],
    descriptions: json["descriptions"],
    fabricMixings: List<FabricMixing>.from(json["fabricMixings"].map((x) => FabricMixing.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "available": available,
    "baseColor": baseColor,
    "slug": slug,
    "thumbnail": thumbnail,
    "favCount": favCount,
    "pricePerYard": pricePerYard,
    "disabled": disabled,
    "descriptions": descriptions,
    "fabricMixings": List<dynamic>.from(fabricMixings.map((x) => x.toJson())),
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
