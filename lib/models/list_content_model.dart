import 'package:see_later_app/models/content_model.dart';

class ListContentModel {
  late List<ContentModel>? items;

  ListContentModel({ this.items});

  factory ListContentModel.fromJson(List<dynamic> json) {
    List<ContentModel> contentList = json.map((item) {
      return ContentModel.fromJson(item as Map<String, dynamic>);
    }).toList();

    return ListContentModel(items: contentList);
  }

  num get length => items!.length;

  ContentModel operator [](int index) {
    return items![index];
  }

  // Método necessário para a desserialização do JSON
  List<Map<String, dynamic>> toJson() =>
      items!.map((item) => item.toJson()).toList();

}