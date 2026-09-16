import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:kharcha/core/util/api_response.dart';

import '../repositories/auth_repository.dart';

class AuthUseCase {
  final AuthRepository repository;

  AuthUseCase({required this.repository});

  Future<Either<String,ApiResponse>> login(String phone,String password) async {
    return await repository.login(phone, password);
  }

  Future<Either<String,ApiResponse>> register(String name,String phone,String password) async {
    return await repository.register(name,phone, password);
  }

  Future<Either<String,ApiResponse>> update(String name,String phone,String password,File? photo) async {
    return await repository.update(name,phone, password,photo);
  }

  Future<Either<String,ApiResponse>> fetch() async {
    return await repository.fetch();
  }

  Future<void> logout() async {
    return await repository.logout();
  }
}
