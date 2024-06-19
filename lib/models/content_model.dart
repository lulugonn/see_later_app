class ContentModel {
  int? id;
  String? title;
  String? url;
  String? type;
  String? notes;
  String? createdAt;
  String? updatedAt;
  bool? seen;
  List<int>? categories;



  ContentModel({
    this.id,
     this.title,
     this.url,
     this.type,
     this.categories,
     this.notes,
     this.createdAt,
     this.updatedAt,
     this.seen,
  });

  factory ContentModel.fromJson(Map<String, dynamic> json) {
    return ContentModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      url: json['url'] as String?,
      type: json['type'] as String?,
      notes: json['notes'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      seen: json['seen'] as bool?,
      categories: json['categories'] as List<int>?,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'title': title!.trim(),
      'url': url!.trim(),
      'type': type!.trim(),
      'notes': notes!.trim(),
      'categories': categories?.map((cat) => cat).toList(),

    };

    return map;
  }
}