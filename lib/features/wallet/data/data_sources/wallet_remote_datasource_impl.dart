import 'wallet_remote_datasource.dart';

class WalletRemoteDataSourceImpl implements WalletRemoteDataSource {
  @override
  Future<String> getWalletData() async {
    return 'Data loaded from WalletRemoteDataSource';
  }
}
