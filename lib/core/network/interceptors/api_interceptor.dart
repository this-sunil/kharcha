

import 'package:dio/dio.dart';
import 'package:kharcha/core/Storage/SecureStorage.dart';
import 'package:kharcha/core/network/dio_network.dart';

class CustomInterceptors extends Interceptor {
  final String? refreshTokenUrl;

  CustomInterceptors({this.refreshTokenUrl});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Add auth tokens or custom headers here
    String? token = await SecureStorage.instance.getToken();
    options.headers['Authorization'] = 'Bearer $token';
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Handle status 401 token refresh or global error interceptors here
    if (err.response?.statusCode == 401) {
      try {
        // 1. Refresh access token
        final newToken = await refreshToken();

        // 2. Save new token
        await SecureStorage.instance.setToken(newToken);

        // 3. Update old request's Authorization header
        err.requestOptions.headers['Authorization'] = 'Bearer $newToken';

        // 4. Retry the original request using the SAME Dio instance
        final response = await Dio().fetch(
          err.requestOptions,
        );

        // 5. Return successful response
        return handler.resolve(response);
      } catch (e) {
        // Refresh token failed
        return handler.next(err);
      }
    }

    return handler.next(err);
  }

  Future<String> refreshToken() async {
    String? id = await SecureStorage.instance.getUID();
    final resp = await DioNetwork().post(
      endpoint: "/auth/refresh",
      data: {"id": id},
      converter: (json) => json,
    );
    final token = await resp.data?['token'] ?? '';
    return token;
  }
}
