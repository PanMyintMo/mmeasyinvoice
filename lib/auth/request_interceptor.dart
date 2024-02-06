import 'package:dio/dio.dart';
import 'package:mmeasyInvoice/util/common/share_util.dart';

class RequestIntecerptor extends Interceptor {
  SharePreferenceService preferenceService = SharePreferenceService();

  RequestIntecerptor() : preferenceService = SharePreferenceService();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await preferenceService.getToken();
    options.headers['Authorization'] = 'Bearer $token';
    options.headers['Accept'] = 'application/json';
    super.onRequest(options, handler);
  }
}
