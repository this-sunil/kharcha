import 'dart:async';
import 'package:dio/dio.dart';
import 'package:kharcha/core/util/api_response.dart';
import 'package:kharcha/core/util/typedefs.dart';

class DioService {
  final Dio _dio;

  Dio get dio => _dio;

  final CancelToken _cancelToken;

  DioService({required Dio dioClient, HttpClientAdapter? httpClientAdapter})
      : _dio = dioClient,
        _cancelToken = CancelToken() {
    if (httpClientAdapter != null) _dio.httpClientAdapter = httpClientAdapter;
  }

  void cancelRequests({CancelToken? cancelToken}) {
    if (cancelToken == null) {
      _cancelToken.cancel('Cancelled');
    } else {
      cancelToken.cancel();
    }
  }

  Future<ApiResponse<T>> get<T>({
    required String endpoint,
    JSON? queryParams,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    final response = await _dio.get<T>(
      endpoint,
      queryParameters: queryParams,
      options: options,
      cancelToken: cancelToken ?? _cancelToken,
    );
    return ApiResponse.success(response.data as T);
  }

  Future<ApiResponse<T>> post<T>({
    required String endpoint,
    JSON? data,
    JSON? queryParams,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    final response = await _dio.post<JSON>(
      endpoint,
      data: data,
      queryParameters: queryParams,
      options: options,
      cancelToken: cancelToken ?? _cancelToken,
    );
    return ApiResponse.success(response.data as T);
  }

  Future<ApiResponse<T>> multipart<T>({
    required String endpoint,
    FormData? data,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
  }) async {
    final response = await _dio.post<JSON>(
      endpoint,
      data: data,
      options: options,
      cancelToken: cancelToken ?? _cancelToken,
      onSendProgress: onSendProgress,
    );
    return ApiResponse.success(response.data as T);
  }

  Future<ApiResponse<T>> patch<T>({
    required String endpoint,
    JSON? data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    final response = await _dio.patch<JSON>(
      endpoint,
      data: data,
      options: options,
      cancelToken: cancelToken ?? _cancelToken,
    );
    return ApiResponse.success(response.data as T);
  }

  Future<ApiResponse<T>> put<T>({
    required String endpoint,
    JSON? data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    final response = await _dio.put<JSON>(
      endpoint,
      data: data,
      options: options,
      cancelToken: cancelToken ?? _cancelToken,
    );
    return ApiResponse.success(response.data as T);
  }

  Future<ApiResponse<T>> delete<T>({
    required String endpoint,
    JSON? data,
    Options? options,
    JSON? queryParams,
    CancelToken? cancelToken,
  }) async {
    final response = await _dio.delete<JSON>(
      endpoint,
      data: data,
      queryParameters: queryParams,
      options: options,
      cancelToken: cancelToken ?? _cancelToken,
    );
    return ApiResponse.success(response.data as T);
  }
}
