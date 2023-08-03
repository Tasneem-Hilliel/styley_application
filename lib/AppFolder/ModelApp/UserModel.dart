import 'package:flutter/material.dart';

class CreateUserModel {
  String? name;
  String? email;
  String? password;
  String? phone;
  String? uId;
  bool? isEmailVerfied;
 String? image;
  String? coverImage;
  String? bio;
  CreateUserModel({
    this.name,
    this.email,
    this.password,
    this.phone,
    this.bio,
    this.coverImage,
    this.image,
this.isEmailVerfied,
    this.uId,
  });
  CreateUserModel.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    email = json["email"];
    password = json["password"];
       phone = json["phone"];
       
    uId = json["uId"];
        isEmailVerfied = json["isEmailVerfied"];
   image = json["image"];
      coverImage = json["coverImage"];
         bio = json["bio"];
    
  }
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "uId": uId,
      "phone":phone,
    "isEmailVerfied":  isEmailVerfied,
     "image": image,
      "bio":bio,
    "coverImage":  coverImage,
    };
  }
}