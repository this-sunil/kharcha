import '../repositories/notification_repository.dart';

class NotificationUseCase {
  final NotificationRepository repository;

  NotificationUseCase({required this.repository});

  Future<String> call() async {
    return await repository.getNotificationData();
  }
}
