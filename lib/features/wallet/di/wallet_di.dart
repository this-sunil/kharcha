import '../data/data_sources/wallet_remote_datasource_impl.dart';
import '../data/repositories/wallet_repository_impl.dart';
import '../domain/usecases/wallet_usecase.dart';

class WalletDI {
  static WalletUseCase provideWalletUseCase() {
    final remoteDataSource = WalletRemoteDataSourceImpl();
    final repository = WalletRepositoryImpl(remoteDataSource: remoteDataSource);
    return WalletUseCase(repository: repository);
  }
}
