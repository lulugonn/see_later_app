class FilterModel {
  bool? seen;
  int? days;
  String? type;
  String? text;
  int? categories;

  FilterModel({
    this.seen,
    this.days,
    this.type,
    this.text,
    this.categories,
  });

  factory FilterModel.fromJson(Map<String, dynamic> json) {
    return FilterModel(
      seen: json['seen'] as bool?,
      days: json['days'] as int?,
      type: json['type'] as String?,
      text: json['text'] as String?,
            categories: json['categories'] as int?,

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'seen': seen!,
      'days': days!,
      'type': type!,
      'text': text!,
      'categories': categories,
    };
  }

  String toQueryString() {
    List<String> params = [];
    if (seen != null) {
      params.add('seen=${seen! ? 'true' : 'false'}');
    }
    if (days != null) {
      params.add('days=$days');
    }
    if (type != null) {
      params.add('type=$type');
    }
    if (text != null) {
      params.add('text=$text');
    }
   if (categories != null) {
      params.add('categories=$categories');
    }
    return params.join('&');
  }
}