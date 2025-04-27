import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiClient {
  late final Dio dio;

  ApiClient() {
    dio = Dio();
    Map<String, String> headers = {
      'accept': '*/*',
      'Content-Type': 'application/json',
    };

    dio.options = BaseOptions(
      // connectTimeout: Duration(seconds: 30),
      // receiveTimeout: Duration(seconds: 30),
      headers: headers,
    );

    if (kReleaseMode) {
      print("release mode no logs");
    } else {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ));
    }
  }
}
