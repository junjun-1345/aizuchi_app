abstract class LocalNotificationRepository {
  Future<void> initializeNotifications();
  Future<void> test();
  Future<void> scheduleDailyNotificationAt(int hour, int minute);
  Future<void> cancelAllNotifications();
}
