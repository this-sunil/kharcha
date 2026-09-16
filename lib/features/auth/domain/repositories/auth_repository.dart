import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:kharcha/core/util/api_response.dart';

abstract class AuthRepository {
  Future<Either<String,ApiResponse>> login(String phone, String password);
  Future<Either<String,ApiResponse>> register(String name,String phone, String password);
  Future<Either<String,ApiResponse>> update(String name,String phone, String password,File? photo);
  Future<Either<String,ApiResponse>> fetch();

  Future<void> logout();
}
