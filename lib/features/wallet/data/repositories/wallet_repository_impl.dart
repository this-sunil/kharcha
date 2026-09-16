import '../../domain/repositories/wallet_repository.dart';
import '../data_sources/wallet_remote_datasource.dart';

class WalletRepositoryImpl implements WalletRepository {
  final WalletRemoteDataSource remoteDataSource;

  WalletRepositoryImpl({required this.remoteDataSource});

  @override
  Future<String> getWalletData() async {
    return await remoteDataSource.getWalletData();
  }
}
