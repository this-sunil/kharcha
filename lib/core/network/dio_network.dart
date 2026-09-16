import 'package:dio/dio.dart';
import 'package:kharcha/core/util/api_response.dart';
import 'package:kharcha/core/util/typedefs.dart';
import 'api_exception.dart';
import 'api_interface.dart';
import 'dio.dart';
import 'dio_services.dart';

class DioNetwork implements ApiInterface {
    static final DioNetwork _instance = DioNetwork._internal();

  factory DioNetwork() {
    return _instance;
  }

  DioNetwork._internal();

  final DioService _dioService = DioService(dioClient: getDio());

  @override
  void cancelRequests({CancelToken? cancelToken}) {
    _dioService.cancelRequests(cancelToken: cancelToken);
  }

  @override
  Future<List<T>> getCollection<T>({
    required String endpoint,
    JSON? queryParams,
    CancelToken? cancelToken,
    required T Function(JSON responseBody) converter,
  }) async {
    try {
      final response = await _dioService.get<List<dynamic>>(
        endpoint: endpoint,
        queryParams: queryParams,
        cancelToken: cancelToken,
      );
      final rawList = response.data ?? [];
      return rawList.map((e) => converter(e as JSON)).toList();
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<ApiResponse<T>> get<T>({
    required String endpoint,
    JSON? queryParams,
    CancelToken? cancelToken,
    required T Function(JSON responseBody) converter,
  }) async {
    try {
      final response = await _dioService.get<JSON>(
        endpoint: endpoint,
        queryParams: queryParams,
        cancelToken: cancelToken,
      );
      return ApiResponse.success(converter(response.data!));
    } on DioException catch (e) {
      final exception = ApiException.fromDioError(e);
      return ApiResponse.error(
        ErrorResponse(
          code: exception.statusCode ?? 500,
          message: exception.message,
          data: exception.errorData,
        ),
      );
    }
  }

  @override
  Future<ApiResponse<T>> post<T>({
    required String endpoint,
    required JSON data,
    CancelToken? cancelToken,
    required T Function(JSON response) converter,
  }) async {
    try {
      final response = await _dioService.post<JSON>(
        endpoint: endpoint,
        data: data,
        cancelToken: cancelToken,
      );
      return ApiResponse.success(converter(response.data!));
    } on DioException catch (e) {
      final exception = ApiException.fromDioError(e);
      return ApiResponse.error(
        ErrorResponse(
          code: exception.statusCode ?? 500,
          message: exception.message,
          data: exception.errorData,
        ),
      );
    }
  }

  @override
  Future<ApiResponse<T>> postFormData<T>({
    required String endpoint,
    required JSON data,
    List<MapEntry<String, MultipartFile>>? files,
    CancelToken? cancelToken,
    required T Function(JSON response) converter,
  }) async {
    try {
      final formData = FormData.fromMap(data);
      if (files != null && files.isNotEmpty) {
        formData.files.addAll(files);
      }
      final response = await _dioService.multipart<JSON>(
        endpoint: endpoint,
        data: formData,
        cancelToken: cancelToken,
      );
      return ApiResponse.success(converter(response.data!));
    } on DioException catch (e) {
      final exception = ApiException.fromDioError(e);
      return ApiResponse.error(
        ErrorResponse(
          code: exception.statusCode ?? 500,
          message: exception.message,
          data: exception.errorData,
        ),
      );
    }
  }

  @override
  Future<ApiResponse<T>> patch<T>({
    required String endpoint,
    required JSON data,
    CancelToken? cancelToken,
    required T Function(JSON response) converter,
  }) async {
    try {
      final response = await _dioService.patch<JSON>(
        endpoint: endpoint,
        data: data,
        cancelToken: cancelToken,
      );
      return ApiResponse.success(converter(response.data!));
    } on DioException catch (e) {
      final exception = ApiException.fromDioError(e);
      return ApiResponse.error(
        ErrorResponse(
          code: exception.statusCode ?? 500,
          message: exception.message,
          data: exception.errorData,
        ),
      );
    }
  }

  @override
  Future<ApiResponse<T>> put<T>({
    required String endpoint,
    required JSON data,
    CancelToken? cancelToken,
    required T Function(JSON response) converter,
  }) async {
    try {
      final response = await _dioService.put<JSON>(
        endpoint: endpoint,
        data: data,
        cancelToken: cancelToken,
      );
      return ApiResponse.success(converter(response.data!));
    } on DioException catch (e) {
      final exception = ApiException.fromDioError(e);
      return ApiResponse.error(
        ErrorResponse(
          code: exception.statusCode ?? 500,
          message: exception.message,
          data: exception.errorData,
        ),
      );
    }
  }

  @override
  Future<ApiResponse<T>> delete<T>({
    required String endpoint,
    JSON? data,
    CancelToken? cancelToken,
    required T Function(JSON response) converter,
  }) async {
    try {
      final response = await _dioService.delete<JSON>(
        endpoint: endpoint,
        data: data,
        cancelToken: cancelToken,
      );
      return ApiResponse.success(converter(response.data!));
    } on DioException catch (e) {
      final exception = ApiException.fromDioError(e);
      return ApiResponse.error(
        ErrorResponse(
          code: exception.statusCode ?? 500,
          message: exception.message,
          data: exception.errorData,
        ),
      );
    }
  }
}
