import 'dart:io';
import 'package:either_dart/either.dart';
import 'package:kharcha/core/util/api_response.dart';

abstract class AuthRemoteDataSource {
  Future<Either<String,ApiResponse>> login(String email,String pass);
  Future<Either<String,ApiResponse>> register(String name,String phone,String pass);
  Future<Either<String,ApiResponse>> updateProfile(String name,String phone,String pass,File? photo);
  Future<Either<String,ApiResponse>> fetchProfile();

  Future<void> logout();
}
