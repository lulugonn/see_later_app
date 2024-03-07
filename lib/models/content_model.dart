class ContentModel {
  int? id;
  String? title;
  String? url;
  String? type;
  String? notes;
  String? createdAt;

  ContentModel({
    this.id,
     this.title,
     this.url,
     this.type,
     this.notes,
     this.createdAt,
  });

  factory ContentModel.fromJson(Map<String, dynamic> json) {
    return ContentModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      url: json['url'] as String?,
      type: json['type'] as String?,
      notes: json['notes'] as String?,
      createdAt: json['createdAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'title': title!.trim(),
      'url': url!.trim(),
      'type': type!.trim(),
      'notes': notes!.trim(),
    };

    return map;
  }
}