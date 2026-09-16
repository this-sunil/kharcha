import 'package:dio/dio.dart';
import 'package:kharcha/core/util/api_response.dart';
import 'package:kharcha/core/util/typedefs.dart';

abstract class ApiInterface {
  const ApiInterface();

  Future<List<T>> getCollection<T>({
    required String endpoint,
    JSON? queryParams,
    CancelToken? cancelToken,
    required T Function(JSON responseBody) converter,
  });

  Future<ApiResponse<T>> get<T>({
    required String endpoint,
    JSON? queryParams,
    CancelToken? cancelToken,
    required T Function(JSON responseBody) converter,
  });

  Future<ApiResponse<T>> post<T>({
    required String endpoint,
    required JSON data,
    CancelToken? cancelToken,
    required T Function(JSON response) converter,
  });

  Future<ApiResponse<T>> postFormData<T>({
    required String endpoint,
    required JSON data,
    List<MapEntry<String, MultipartFile>>? files,
    CancelToken? cancelToken,
    required T Function(JSON response) converter,
  });

  Future<ApiResponse<T>> patch<T>({
    required String endpoint,
    required JSON data,
    CancelToken? cancelToken,
    required T Function(JSON response) converter,
  });

  Future<ApiResponse<T>> put<T>({
    required String endpoint,
    required JSON data,
    CancelToken? cancelToken,
    required T Function(JSON response) converter,
  });

  Future<ApiResponse<T>> delete<T>({
    required String endpoint,
    JSON? data,
    CancelToken? cancelToken,
    required T Function(JSON response) converter,
  });

  void cancelRequests({CancelToken? cancelToken});
}
