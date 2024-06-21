import 'package:see_later_app/models/content_request_model.dart';
import 'package:see_later_app/models/content_response_model.dart';

class ListContentRequestModel {
  late List<ContentRequestModel>? items;

  ListContentRequestModel({ this.items});

  factory ListContentRequestModel.fromJson(List<dynamic> json) {
    List<ContentRequestModel> contentList = json.map((item) {
      return ContentRequestModel.fromJson(item as Map<String, dynamic>);
    }).toList();

    return ListContentRequestModel(items: contentList);
  }

  num get length => items!.length;

  ContentRequestModel operator [](int index) {
    return items![index];
  }

  List<Map<String, dynamic>> toJson() =>
      items!.map((item) => item.toJson()).toList();

}