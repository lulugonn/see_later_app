import 'package:see_later_app/models/content_model.dart';

class ListContentModel {
  List<ContentModel> items;

  ListContentModel({required this.items});

  // Método necessário para a desserialização do JSON
  List<Map<String, dynamic>> toJson() =>
      items.map((item) => item.toJson()).toList();
}