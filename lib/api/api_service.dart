import 'package:see_later_app/controllers/auth_controller.dart';
import 'package:see_later_app/models/content_model.dart';
import 'package:see_later_app/models/list_content_model.dart';
import 'package:see_later_app/models/login_model.dart';
import 'package:see_later_app/models/register_model.dart';
import 'package:dio/dio.dart';


class APIService {
  String url = "https://see-later-api-deploy.onrender.com";
  final dio = Dio();

  Future<void> login(LoginRequestModel requestModel) async {
    try {
      dio.options.headers["Access-Control-Allow-Origin"] = "*";
      final response = await dio.post('$url/auth/sign-in', data: requestModel.toJson());
      if (response.statusCode == 200) {
        await AuthController.setToken(response.data['token']);
      }
    }on DioException catch (e) {
      if(e.response != null){
        var errorMessage =  e.response!.data['message'];
        var message = '';
        if(errorMessage is List){
          for (var item in errorMessage) {
            message += ('- $item\n');
          }
        }else{
          message = errorMessage;
        }
        throw message;
      }else{
        throw 'Ocorreu um erro inesperado';
      }
    }
  }

  Future<void> register(RegisterRequestModel requestModel) async {
    try {
      dio.options.headers["Access-Control-Allow-Origin"] = "*";
      final response = await dio.post('$url/auth/sign-up', data: requestModel.toJson());
      if (response.statusCode == 200) {
          await AuthController.setToken(response.data['token']);
      }
    }on DioException catch (e) {
      if(e.response != null){
        var errorMessage =  e.response!.data['message'];
        var message = '';
        if(errorMessage is List){
          for (var item in errorMessage) {
            message += ('- $item\n');
          }
        }else{
          message = errorMessage;
        }
        throw message;
      }else{
        throw 'Ocorreu um erro inesperado';
      }
    }
  }

  Future<String?> registerContent(ContentModel requestModel) async {
    try {
      String? token = await AuthController.getToken();
      dio.options.headers["Authorization"] = "Bearer $token";
      final response = await dio.post('$url/content', data: requestModel.toJson());
      if(response.statusCode == 201){
         return 'Conteúdo criado com sucesso!';
      }
      return null;
    }on DioException catch (e) {
      if(e.response != null){
        var errorMessage =  e.response!.data['message'];
        var message = '';
        if(errorMessage is List){
          for (var item in errorMessage) {
            message += ('- $item\n');
          }
        }else{
          message = errorMessage;
        }
        throw message;
      }else{
        throw 'Ocorreu um erro inesperado';
      }
    }
  }

  Future<String?> deleteContent(id) async {
    try {
      String? token = await AuthController.getToken();
      dio.options.headers["Authorization"] = "Bearer $token";
      final response = await dio.delete('$url/content/$id');
      if(response.statusCode == 204){
         return 'Deletado  com sucesso!';
      }
      return null;
    }on DioException catch (e) {
      if(e.response != null){
        var errorMessage =  e.response!.data['message'];
        var message = '';
        if(errorMessage is List){
          for (var item in errorMessage) {
            message += ('- $item\n');
          }
        }else{
          message = errorMessage;
        }
        throw message;
      }else{
        throw 'Ocorreu um erro inesperado';
      }
    }
  }

  Future<ListContentModel?> getContent() async {
    try {
      String? token = await AuthController.getToken();
      dio.options.headers["Authorization"] = "Bearer $token";
      final response = await dio.get('$url/content');
      if(response.statusCode == 204){
         return null;
      }else{
        final data = response.data as List<dynamic>;
        return ListContentModel.fromJson(data);
      }
    }on DioException catch (e) {
      if(e.response != null){
        var errorMessage =  e.response!.data['message'];
        var message = '';
        if(errorMessage is List){
          for (var item in errorMessage) {
            message += ('- $item\n');
          }
        }else{
          message = errorMessage;
        }
        throw message;
      }else{
        throw 'Ocorreu um erro inesperado';
      }
    }
  }

  Future<String?> updateContent(ContentModel requestModel) async {
    try {
      String? token = await AuthController.getToken();
      dio.options.headers["Authorization"] = "Bearer $token";
      final response = await dio.patch('$url/content/${requestModel.id}', data: requestModel.toJson());
      if(response.statusCode == 201){
         return 'Conteúdo atualizado com sucesso!';
      }
      return null;
    }on DioException catch (e) {
      if(e.response != null){
        var errorMessage =  e.response!.data['message'];
        var message = '';
        if(errorMessage is List){
          for (var item in errorMessage) {
            message += ('- $item\n');
          }
        }else{
          message = errorMessage;
        }
        throw message;
      }else{
        throw 'Ocorreu um erro inesperado';
      }
    }
  }

}
