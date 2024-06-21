import 'package:see_later_app/models/tag_model.dart';

class ContentResponseModel {
  int? id;
  String? title;
  String? url;
  String? type;
  String? notes;
  String? createdAt;
  String? updatedAt;
  bool? seen;
  bool? favorite;
  List<TagModel>? categories;

  ContentResponseModel({
    this.id,
    this.title,
    this.url,
    this.type,
    this.categories,
    this.notes,
    this.createdAt,
    this.updatedAt,
    this.seen,
    this.favorite,
  });

  factory ContentResponseModel.fromJson(Map<String, dynamic> json) {
    List<dynamic>? jsonCategories = json['categories'];
    List<TagModel>? tagModels;
    if (jsonCategories != null) {
      tagModels = jsonCategories.map((category) => TagModel.fromJson(category)).toList();
    }

    return ContentResponseModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      url: json['url'] as String?,
      type: json['type'] as String?,
      notes: json['notes'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      seen: json['seen'] as bool?,
      favorite: json['favorite'] as bool?,
      categories: tagModels,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'id': id,
      'title': title!.trim(),
      'url': url!.trim(),
      'type': type!.trim(),
      'notes': notes!.trim(),
      'createdAt': createdAt!,
      'updatedAt': updatedAt!,
      'seen': seen!,
      'favorite': favorite!,
      'categories': categories?.map((cat) => cat.toJson()).toList(),
    };

    return map;
  }
}