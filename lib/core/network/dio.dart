import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:kharcha/core/network/interceptors/api_interceptor.dart';
import 'package:kharcha/core/network/interceptors/logging.dart';
import "package:flutter_dotenv/flutter_dotenv.dart";
Dio getDio({String? baseUrl}) {
  Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl ?? dotenv.env["BASE_URL"].toString(),
      connectTimeout: const Duration(seconds: 90),
      receiveTimeout: const Duration(seconds: 90),
      responseType: ResponseType.json,
    ),
  )..interceptors.addAll([
      CustomInterceptors(),
    ]);

  if (kDebugMode) {
    dio.interceptors.add(Logging());
  }

  return dio;
}
