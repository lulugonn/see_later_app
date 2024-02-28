import 'package:http/http.dart' as http;
import 'package:see_later_app/models/login_model.dart';
import 'dart:convert';
import 'package:see_later_app/models/register_model.dart';
import 'package:dio/dio.dart';


class APIService {
  String url = "https://see-later-api-deploy.onrender.com";
  final dio = Dio();

  Future<LoginResponseModel?> login(LoginRequestModel requestModel) async {
    try {
      final response = await dio.post('$url/auth/sign-in', data: requestModel);
      if (response.statusCode == 200) {
        return response.data!;
      }
      return null;
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

  Future<RegisterRequestModel?> register(RegisterRequestModel requestModel) async {
    try {
      final response = await dio.post('$url/auth/sign-up', data: requestModel);
      if (response.statusCode == 200) {
        return response.data!;
      }
      return null;
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
