import 'package:flutter/material.dart';

enum Status { empty, loading, success, error }

class ApiResponse<T> {
  final Status status;
  final T? data;
  final ErrorResponse? message;

  ApiResponse._({required this.status, this.data, this.message});

  factory ApiResponse.empty() => ApiResponse._(status: Status.empty);

  factory ApiResponse.loading() => ApiResponse._(status: Status.loading);

  factory ApiResponse.success(T data) =>
      ApiResponse._(status: Status.success, data: data);

  factory ApiResponse.error(ErrorResponse message) =>
      ApiResponse._(status: Status.error, message: message);

  bool get isEmpty => status == Status.empty;
  bool get isLoading => status == Status.loading;
  bool get isSuccess => status == Status.success;
  bool get isError => status == Status.error;
}

extension ApiResponseWidgetX<T> on ApiResponse<T> {
  Widget when({
    Widget Function()? empty,
    Widget Function()? loading,
    required Widget Function(T data) success,
    Widget Function(ErrorResponse error)? error,
  }) {
    switch (status) {
      case Status.empty:
        return empty?.call() ?? const Text('No data');
      case Status.loading:
        return loading?.call() ??
            const Center(child: CircularProgressIndicator());
      case Status.success:
        return success(data as T);
      case Status.error:
        return error?.call(message!) ??
            Text('Error: ${message?.message ?? 'Unknown error'}');
    }
  }
}

extension ApiResponseHandlerX<T> on ApiResponse<T> {
  void whenStatus({
    void Function()? empty,
    void Function()? loading,
    void Function(T data)? success,
    void Function(ErrorResponse error)? error,
  }) {
    switch (status) {
      case Status.empty:
        empty?.call();
        break;
      case Status.loading:
        loading?.call();
        break;
      case Status.success:
        if (data != null) success?.call(data as T);
        break;
      case Status.error:
        if (message != null) error?.call(message!);
        break;
    }
  }
}

class ErrorResponse {
  final int code;
  final String message;
  final dynamic data;

  ErrorResponse({required this.code, required this.message, this.data});

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
      code: json['code'] ?? 0,
      message: json['message'] ?? 'Unknown error',
      data: json['data'],
    );
  }
}
