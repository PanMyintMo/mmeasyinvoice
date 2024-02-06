import 'package:dio/dio.dart';
import 'package:mmeasyInvoice/auth/request_interceptor.dart';
import 'package:mmeasyInvoice/util/app_url.dart';

class ApiService {
  static final _dio = Dio();

  ApiService._internal() {
    dio.options = BaseOptions(
      connectTimeout: const Duration(milliseconds: 1000),
      receiveTimeout: const Duration(milliseconds: 1000),
      baseUrl: AppUrl.baseUrl,
      contentType: 'application/json',
    );

    dio.interceptors.add(RequestIntecerptor());

    //logger.e("Dio Headers: ${dio.options.headers}");
  }

  static Dio get dio => _dio;

  // Singleton instance
  static final ApiService _instance = ApiService._internal();

  factory ApiService() {
    return _instance;
  }
}
