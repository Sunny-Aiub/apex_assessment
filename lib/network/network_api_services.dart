import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../constants/network_constants.dart';
import '../resources/exceptions.dart';
import 'base_api_services.dart';

class NetworkApiServices extends BaseApiServices {
  final dio = Dio();

  NetworkApiServices() {
    dio.options = BaseOptions(
      headers: {
        'Content-Type': 'application/json',
      },
    );
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      compact: true,
    ));
  }

  @override
  Future<dynamic> getApi(String url) async {
    dynamic responseJson;
    try {
      final response =
          await dio.get(url).timeout(const Duration(seconds: timeOutDuration));
      responseJson = returnResponse(response);
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectionError || e.type == DioErrorType.unknown) {
        throw InternetException(e.error.toString());
      } else if (e.type == DioErrorType.connectionTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        throw TimeoutException(e.error.toString());
      } else {
        throw FetchDataException(e.message.toString());
      }
    }
    return responseJson;
  }

  @override
  Future postApi(String url, var data) async {
    dynamic responseJson;
    try {
      final response = await dio
          .post(url, data: jsonEncode(data))
          .timeout(const Duration(seconds: timeOutDuration));
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException();
    } on RequestTimeoutException {
      throw RequestTimeoutException();
    }
    return responseJson;
  }

  returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = response.data; //jsonDecode(response.data);
        return responseJson;
      case 201:
        dynamic responseJson = response.data; //jsonDecode(response.data);
        return responseJson;

      case 400:
        dynamic responseJson = response.data; //jsonDecode(response.data);
        return responseJson;

      case 403:
        throw UnauthorisedException(response.data.toString());

      case 404:
        throw PageNotFoundException(response.data.toString());

      default:
        throw FetchDataException(
            'Error occured while communication with server' +
                ' with status code : ${response.statusCode}');
    }
  }
}
