import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:kharcha/core/util/api_response.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth_remote_datasource.dart';


class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<String,ApiResponse>> login(String phone, String pass) async {
    return remoteDataSource.login(phone, pass);
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<Either<String, ApiResponse<dynamic>>> register(String name, String phone, String password) {
    // TODO: implement register
    return remoteDataSource.register(name,phone, password);
  }

  @override
  Future<Either<String, ApiResponse<dynamic>>> fetch() {
    // TODO: implement fetch
    return remoteDataSource.fetchProfile();
  }

  @override
  Future<Either<String, ApiResponse<dynamic>>> update(String name, String phone, String password,File? photo) {
    // TODO: implement update
    return remoteDataSource.updateProfile(name, phone, password,photo);
  }
}
