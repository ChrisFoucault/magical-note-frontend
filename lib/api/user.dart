import 'request.dart';
import 'package:dio/dio.dart';

class UserApi {
  static final Dio _dio = ApiClient.instance;

  static Future<Response> login(int id) async {
    final response = await _dio.get('/users/login');
    return response;
  }
}