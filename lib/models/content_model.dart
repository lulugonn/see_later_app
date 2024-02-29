class ContentModel {
  String? title;
  String? url;
  String? notes;

  ContentModel({
     this.title,
     this.url,
     this.notes,
  });

  factory ContentModel.fromJson(Map<String, dynamic> json) {
    return ContentModel(
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