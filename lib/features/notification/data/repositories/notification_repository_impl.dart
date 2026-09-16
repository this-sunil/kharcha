import '../../domain/repositories/notification_repository.dart';
import '../data_sources/notification_remote_datasource.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource remoteDataSource;

  NotificationRepositoryImpl({required this.remoteDataSource});

  @override
  Future<String> getNotificationData() async {
    return await remoteDataSource.getNotificationData();
  }
}
