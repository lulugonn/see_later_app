import 'package:see_later_app/models/tag_model.dart';

class ListTagModel {
  List<TagModel>? items;

  ListTagModel({this.items});

  factory ListTagModel.fromJson(List<dynamic> json) {
    List<TagModel> tagList = json.map((item) {
      return TagModel.fromJson(item as Map<String, dynamic>);
    }).toList();

    return ListTagModel(items: tagList);
  }

  List<Map<String, dynamic>> toJson() {
    return items?.map((item) => item.toJson()).toList() ?? [];
  }

  int get length => items?.length ?? 0;

  TagModel? operator [](int index) {
    return items?[index];
  }
}