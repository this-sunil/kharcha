import 'dart:io';
import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic errorData;

  ApiException({required this.message, this.statusCode, this.errorData});

  factory ApiException.fromDioError(DioException e) {
    String errorMsg = 'Unexpected error occurred';
    dynamic errorBody;

    // Connection / timeout handling
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return ApiException(
        message: "Connection timed out. Please try again.",
        statusCode: 408,
      );
    }

    if (e.type == DioExceptionType.connectionError ||
        e.error is SocketException) {
      return ApiException(
        message: "No internet connection. Please check your network.",
        statusCode: 503,
      );
    }

    if (e.type == DioExceptionType.cancel) {
      return ApiException(
        message: "Request was cancelled.",
        statusCode: 499,
      );
    }

    // Server response error
    if (e.response != null) {
      final status = e.response?.statusCode;
      errorBody = e.response?.data;

      if (errorBody is Map && errorBody['message'] != null) {
        errorMsg = errorBody['message'];
      } else if (errorBody is String) {
        errorMsg = errorBody;
      } else {
        errorMsg = "Something went wrong. Please try again.";
      }

      return ApiException(
        message: errorMsg,
        statusCode: status,
        errorData: errorBody,
      );
    }

    return ApiException(message: e.message ?? errorMsg, statusCode: 500);
  }
}
