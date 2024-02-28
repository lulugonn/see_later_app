class ContentRequestModel {
  String? title;
  String? url;
  String? notes;

  ContentRequestModel({
     this.title,
     this.url,
     this.notes,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'title': title!.trim(),
      'url': url!.trim(),
      'notes': notes!.trim(),
    };

    return map;
  }
}