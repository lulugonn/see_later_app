import 'package:flutter_tagging_plus/flutter_tagging_plus.dart';

class TagModel extends Taggable  {
  int? id;
  String name;
  int? userId;
  String? createdAt;
  String? updatedAt;


  TagModel({
    this.id,
     required this.name,
     this.userId,
     this.createdAt,
     this.updatedAt,
  });

  factory TagModel.fromJson(Map<String, dynamic> json) {
    return TagModel(
      id: json['id'] as int?,
      name: json['name'] as String,
      userId: json['userId'] as int?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'name': name!.trim(),
      'id': id!.toString().trim(),
    };

    return map;
  }
 @override
  List<Object> get props => [name];
}