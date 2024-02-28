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