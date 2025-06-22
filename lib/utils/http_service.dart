import 'package:dio/dio.dart';

class HttpService {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://10.0.2.2:8080', // 本地服务地址，Android 模拟器用这个
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  // 可添加 token 拦截器等
  static void addInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print('➡️ 请求: ${options.method} ${options.uri}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print('✅ 响应: ${response.statusCode} ${response.data}');
          return handler.next(response);
        },
        onError: (e, handler) {
          print('❌ 错误: ${e.message}');
          return handler.next(e);
        },
      ),
    );
  }

  static Future<Response> get(String path, {Map<String, dynamic>? params}) async {
    return await _dio.get(path, queryParameters: params);
  }

  static Future<Response> post(String path, {dynamic data}) async {
    return await _dio.post(path, data: data);
  }

  static Future<Response> put(String path, {dynamic data}) async {
    return await _dio.put(path, data: data);
  }

  static Future<Response> delete(String path, {Map<String, dynamic>? params}) async {
    return await _dio.delete(path, queryParameters: params);
  }
}
