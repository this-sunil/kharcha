import '../repositories/wallet_repository.dart';

class WalletUseCase {
  final WalletRepository repository;

  WalletUseCase({required this.repository});

  Future<String> call() async {
    return await repository.getWalletData();
  }
}
