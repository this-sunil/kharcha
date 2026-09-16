import '../data/data_sources/auth_remote_datasource_impl.dart';
import '../data/repositories/auth_repository_impl.dart';
import '../domain/usecases/auth_usecase.dart';

class AuthDI {
  static AuthUseCase provideAuthUseCase() {
    final remoteDataSource = AuthRemoteDataSourceImpl();
    final repository = AuthRepositoryImpl(remoteDataSource: remoteDataSource);
    return AuthUseCase(repository: repository);
  }
}
