import 'package:dio/dio.dart';

class ApiClient {
  static final Dio _dio = _initDio();

  static Dio _initDio() {
    final dio = Dio(BaseOptions(
      baseUrl: 'http://localhost:8080',
      headers: {'Accept': 'application/json'},
    ));

    // 添加拦截器
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // 自动添加Token
        // options.headers['Authorization'] = 'Bearer ${_getToken()}';
        return handler.next(options);
      },
      onError: (e, handler) async {
        // if (e.response?.statusCode == 401) {
        //   await _refreshToken();
        //   return handler.resolve(await _retry(e.requestOptions));
        // }
        return handler.next(e);
      },
    ));

    return dio;
  }

  static Dio get instance => _dio;
}