// ignore_for_file: public_member_api_docs, sort_constructors_first
class AppCreateUserModel {
  String? name;
  String? email;
  String? uid;
  String? phone;
  bool? isEmailVerified;
  String? image;
  String? cover;
  String? bio;
  AppCreateUserModel({
    this.name,
    this.email,
    this.uid,
    this.phone,
    this.image,
    this.cover,
    this.bio,
    this.isEmailVerified,
  });
  AppCreateUserModel.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    image = json["image"];
    bio = json["bio"];
    email = json["email"];
    phone = json["phone"];
    uid = json["uid"];
    cover = json["cover"];
    isEmailVerified = json["isEmailVerified"];
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "phone": phone,
      "uid": uid,
      "bio": bio,
      "image": image,
      "cover": cover,
      "isEmailVerified": isEmailVerified,
    };
  }
}
