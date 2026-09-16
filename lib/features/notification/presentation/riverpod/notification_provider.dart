import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../di/notification_di.dart';
import '../../domain/usecases/notification_usecase.dart';

class NotificationNotifier extends StateNotifier<AsyncValue<String>> {
  final NotificationUseCase useCase;

  NotificationNotifier(this.useCase) : super(const AsyncValue.loading()) {
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

final notificationNotifierProvider =
    StateNotifierProvider<NotificationNotifier, AsyncValue<String>>((ref) {
  final useCase = NotificationDI.provideNotificationUseCase();
  return NotificationNotifier(useCase);
});
