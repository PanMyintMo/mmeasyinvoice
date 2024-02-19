import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mmeasyInvoice/data/app_exception.dart';
import 'package:mmeasyInvoice/data/network/BaseApiServices.dart';

class NetworkApiService extends BaseApiService {
  @override
  Future getPostApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    try {
      final response =
          await dio.post(url, data: data).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJson;
    // logger.e('${dio.get(url)}');

    try {
      final response = await dio.get(url).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  @override
  Future getPostApiforIdResponse(String url) async {
    dynamic responseJosn;
    try {
      final response = await dio.post(url).timeout(const Duration(seconds: 10));
      responseJosn = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJosn;
  }
}

dynamic returnResponse(Response response) {
  switch (response.statusCode) {
    case 200:
      return response.data;

    case 400:
      throw BadRequestException(response.statusMessage.toString());

    case 500:
      throw UnauthorizedException(response.statusMessage.toString());
    case 404:
      throw UnauthorizedException(response.statusMessage.toString());
    default:
      throw FetchDataException('Error: ${response.statusCode}');
  }
}
