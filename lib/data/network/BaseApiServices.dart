import 'package:dio/dio.dart';
import 'package:mmeasyInvoice/data/network/ApiService.dart';

abstract class BaseApiService {
  final Dio dio = ApiService.dio;
  Future<dynamic> getGetApiResponse(String url);
  Future<dynamic> getPostApiResponse(String url, dynamic data);
}
