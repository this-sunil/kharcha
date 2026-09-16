import 'notification_remote_datasource.dart';

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  @override
  Future<String> getNotificationData() async {
    return 'Data loaded from NotificationRemoteDataSource';
  }
}
