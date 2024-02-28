import 'package:http/http.dart' as http;
import 'package:see_later_app/controllers/auth_controller.dart';
import 'package:see_later_app/models/login_model.dart';
import 'dart:convert';
import 'package:see_later_app/models/register_model.dart';
import 'package:dio/dio.dart';


class APIService {
  String url = "https://see-later-api-deploy.onrender.com";
  final dio = Dio();

  Future<void> login(LoginRequestModel requestModel) async {
    try {
      final response = await dio.post('$url/auth/sign-in', data: requestModel.toJson());
      if (response.statusCode == 200) {
        await AuthController.setToken(response.data['token']);
      }
    }on DioException catch (e) {
      if(e.response != null){
        var errorMessage =  e.response!.data['message'];
        var message = '';
        errorMessage.forEach((item) {
          message += ('- $item\n');
        });
        throw message;
      }else{
        throw 'Ocorreu um erro inesperado';
      }
    }
  }

  Future<void> register(RegisterRequestModel requestModel) async {
    try {
      final response = await dio.post('$url/auth/sign-up', data: requestModel.toJson());
      if (response.statusCode == 200) {
          await AuthController.setToken(response.data['token']);
      }
    }on DioException catch (e) {
      if(e.response != null){
        var errorMessage =  e.response!.data['message'];
        var message = '';
        errorMessage.forEach((item) {
          message += ('- $item\n');
        });
        throw message;
      }else{
        throw 'Ocorreu um erro inesperado';
      }
    }
  }
}
