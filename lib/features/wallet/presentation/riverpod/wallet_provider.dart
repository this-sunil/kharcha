import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../di/wallet_di.dart';
import '../../domain/usecases/wallet_usecase.dart';

class WalletNotifier extends StateNotifier<AsyncValue<String>> {
  final WalletUseCase useCase;

  WalletNotifier(this.useCase) : super(const AsyncValue.loading()) {
    loadData();
  }

  Future<void> loadData() async {
    state = const AsyncValue.loading();
    try {
      final result = await useCase();
      state = AsyncValue.data(result);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

final walletNotifierProvider =
    StateNotifierProvider<WalletNotifier, AsyncValue<String>>((ref) {
  final useCase = WalletDI.provideWalletUseCase();
  return WalletNotifier(useCase);
});
