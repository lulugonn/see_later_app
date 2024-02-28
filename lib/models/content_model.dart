class ContentModel {
  int? id;
  String? title;
  String? url;
  String? notes;

  ContentModel({
    this.id,
     this.title,
     this.url,
     this.notes,
  });

  factory ContentModel.fromJson(Map<String, dynamic> json) {
    return ContentModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      url: json['url'] as String?,
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'id': title!.trim(),
      'title': title!.trim(),
      'url': url!.trim(),
      'notes': notes!.trim(),
    };

    return map;
  }
}