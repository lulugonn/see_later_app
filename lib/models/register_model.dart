class RegisterResponseModel {
  final String token;
  final String error;

  RegisterResponseModel({required this.token, required this.error});

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      token: json["token"] != null ? json["token"] : "",
      error: json["error"] != null ? json["error"] : "",
    );
  }
}

class RegisterRequestModel {
  String? name;
  String? email;
  String? confirm_email;
  String? password;

  RegisterRequestModel({
     this.name,
     this.email,
     this.confirm_email,
     this.password,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'name': name!.trim(),
      'email': email!.trim(),
      'confirm_email': confirm_email!.trim(),
      'password': password!.trim(),
    };

    return map;
  }
}