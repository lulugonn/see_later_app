import 'package:flutter_tagging_plus/flutter_tagging_plus.dart';

class TagModel extends Taggable {
  int? id;
  String? name;

  TagModel({
    this.id,
    this.name,
  });

  factory TagModel.fromJson(Map<String, dynamic> json) {
    return TagModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name!.trim(),
      'id': id!.toString().trim(),
    };
  }
@override
  List<Object> get props => [name!];

  @override
  String toString() {
    return 'TagModel{id: $id, name: $name}';
  }
}