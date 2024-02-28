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