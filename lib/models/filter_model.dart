class FilterModel {
  bool? seen;

  FilterModel({
    this.seen,
  });

  factory FilterModel.fromJson(Map<String, dynamic> json) {
    return FilterModel(
      seen: json['seen'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'seen': seen!,
    };
  }

}