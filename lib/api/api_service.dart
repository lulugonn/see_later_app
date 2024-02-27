import 'package:http/http.dart' as http;
import 'package:see_later_app/models/login_model.dart';
import 'dart:convert';

import 'package:see_later_app/models/register_model.dart';

class APIService {

  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    String url = "https://see-later-api-deploy.onrender.com/auth/sign-in";

    final response = await http.post(Uri.parse(url), body: requestModel.toJson());
    if (response.statusCode == 200) {
      return LoginResponseModel.fromJson(
        json.decode(response.body),
      );
    } else {
      return throw Exception('Failed to load data!');
    }
  }

  Future<LoginResponseModel> register(RegisterRequestModel requestModel) async {
    String url = "https://see-later-api-deploy.onrender.com/auth/sign-up";

    final response = await http.post(Uri.parse(url), body: requestModel.toJson());
    if (response.statusCode == 200) {
      return LoginResponseModel.fromJson(
        json.decode(response.body),
      );
    } else {
      return throw Exception('Failed to load data!');
    }
  }
}