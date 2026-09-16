import '../data/data_sources/notification_remote_datasource_impl.dart';
import '../data/repositories/notification_repository_impl.dart';
import '../domain/usecases/notification_usecase.dart';

class NotificationDI {
  static NotificationUseCase provideNotificationUseCase() {
    final remoteDataSource = NotificationRemoteDataSourceImpl();
    final repository = NotificationRepositoryImpl(remoteDataSource: remoteDataSource);
    return NotificationUseCase(repository: repository);
  }
}
