
class LoginResponseModel {
  final String token;
  final Map<String,dynamic> message;

  LoginResponseModel({required this.token, required this.message});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      token: json["token"] != null ? json["token"] : "",
      message: json["message"] != null ? json["message"] : "",
    );
  }
}

class LoginRequestModel {
  String? email;
  String? password;

  LoginRequestModel({
     this.email,
     this.password,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'email': email!.trim(),
      'password': password!.trim(),
    };

    return map;
  }
}