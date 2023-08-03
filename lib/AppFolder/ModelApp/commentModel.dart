// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
 
  String? name;
  Timestamp? delivered;
  String? comment;
  CommentModel({
    this.name,
    this.delivered,
    this.comment,
  });

  


  
  CommentModel.fromJson(Map<String, dynamic> json) {
   
    name = json['name'];
    delivered = json['delivered'];
    comment = json['comment'];

   
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['delivered'] = this.delivered;
    data['comment'] = this.comment;
   

    return data;
  }
}
