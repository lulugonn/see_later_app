import 'package:see_later_app/models/content_request_model.dart';
import 'package:see_later_app/models/content_response_model.dart';

class ListContentResponseModel {
  late List<ContentResponseModel>? items;

  ListContentResponseModel({ this.items});

  factory ListContentResponseModel.fromJson(List<dynamic> json) {
    List<ContentResponseModel> contentList = json.map((item) {
      return ContentResponseModel.fromJson(item as Map<String, dynamic>);
    }).toList();

    return ListContentResponseModel(items: contentList);
  }

  num get length => items!.length;

  ContentResponseModel operator [](int index) {
    return items![index];
  }

  List<Map<String, dynamic>> toJson() =>
      items!.map((item) => item.toJson()).toList();

}