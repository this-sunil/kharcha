import 'dart:io';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:kharcha/core/Storage/SecureStorage.dart';
import 'package:kharcha/core/util/api_response.dart';
import '../../../../core/network/dio_network.dart';
import '../models/auth_model.dart';
import 'auth_remote_datasource.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<Either<String, ApiResponse>> login(String phone, String pass) async {
    try {
      final response = await DioNetwork().post<AuthModel>(
        endpoint: '/auth/login',
        data: {'phone': phone, 'pass': pass},
        converter: (json) => AuthModel.fromJson(json),
      );

      return Right(ApiResponse.success(response.data));
    } on DioException catch (e) {
      // Handle or rethrow API/network level exceptions
      return Left(e.message.toString());
    } catch (e) {
      // Handle unexpected errors
      return Left("Something Went Wrong !!!");
    }
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<Either<String, ApiResponse<dynamic>>> register(
    String name,
    String phone,
    String pass,
  ) async {
    // TODO: implement register
    try {
      final response = await DioNetwork().post<AuthModel>(
        endpoint: '/auth/register',
        data: {'name': name, 'phone': phone, 'pass': pass},
        converter: (json) => AuthModel.fromJson(json),
      );

      return Right(ApiResponse.success(response.data));
    } on DioException catch (e) {
      // Handle or rethrow API/network level exceptions
      return Left(e.message.toString());
    } catch (e) {
      // Handle unexpected errors

      return Left("Something Went Wrong !!!");
    }
  }

  @override
  Future<Either<String, ApiResponse<dynamic>>> fetchProfile() async {
    // TODO: implement fetchProfile
    try {
      String? id = await SecureStorage.instance.getUID();
      final response = await DioNetwork().post(

        endpoint: "/auth/getProfile",
        data: {'id': id},
        converter: (json) => AuthModel.fromJson(json),
      );
      return Right(ApiResponse.success(response.data));
    } on DioException catch (e) {
      return Left(e.message.toString());
    } catch (e) {
      return Left("Something Went Wrong !!!");
    }
  }

  @override
  Future<Either<String, ApiResponse<dynamic>>> updateProfile(
    String name,
    String phone,
    String pass,
    File? photos,
  ) async {
    // TODO: implement updateProfile
    try {
      final file = await MultipartFile.fromFile(
        photos!.path,
        filename: photos.path.split('/').last,
      );
      final response = await DioNetwork().post<AuthModel>(
        endpoint: '/auth/update',
        data: {'name': name, 'phone': phone, 'pass': pass, 'photo': file},
        converter: (json) => AuthModel.fromJson(json),
      );

      return Right(ApiResponse.success(response.data));
    } on DioException catch (e) {
      // Handle or rethrow API/network level exceptions
      return Left(e.message.toString());
    } catch (e) {
      // Handle unexpected errors
      return Left("Something Went Wrong !!!");
    }
  }
}
