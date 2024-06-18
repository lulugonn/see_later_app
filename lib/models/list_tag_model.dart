
import 'package:see_later_app/models/tag_model.dart';

class ListTagModel  {
  late List<TagModel>? items;

  ListTagModel({ this.items});

  factory ListTagModel.fromJson(List<dynamic> json) {
    List<TagModel> contentList = json.map((item) {
      return TagModel.fromJson(item as Map<String, dynamic>);
    }).toList();

    return ListTagModel(items: contentList);
  }

  num get length => items!.length;

  TagModel operator [](int index) {
    return items![index];
  }

  // Método necessário para a desserialização do JSON
  List<Map<String, dynamic>> toJson() =>
      items!.map((item) => item.toJson()).toList();

}