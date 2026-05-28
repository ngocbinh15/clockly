import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService extends GetxService {
  late AndroidInitializationSettings androidInitializationSettings;
  late InitializationSettings initializationSettings;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  late tz.Location location;

  @override
  void onInit() {
    super.onInit();
    androidInitializationSettings = const AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    location = tz.getLocation('Asia/Ho_Chi_Minh');
    initialize();
  }

  Future<void> initialize() async {
    await flutterLocalNotificationsPlugin.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: (details) {},
    );
  }

  Future<void> setAllTasksNotification(
    int id,
    int totalTasks,
    DateTime date,
  ) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
          'daily_digest_channel',
          'Daily Notification',
          priority: Priority.high,
          importance: Importance.max,
        );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    final time = tz.TZDateTime(location, date.year, date.month, date.day, 8, 0);

    String title = totalTasks > 0
        ? 'Good morning! ☀️'
        : 'Relaxing day ahead! ☕';
    String body = totalTasks > 0
        ? 'You have $totalTasks tasks waiting. Let\'s get things done!'
        : 'No tasks scheduled for today. Take some time to recharge!';

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: time,
      notificationDetails: notificationDetails,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
  }

  Future<void> setSingleTaskNotification(
    int id,
    String taskName,
    DateTime date,
  ) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
          'single_task_channel',
          'Single Task Notification',
          priority: Priority.high,
          importance: Importance.max,
        );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    final time = tz.TZDateTime(
      location,
      date.year,
      date.month,
      date.day,
      date.hour,
      date.minute,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id: id,
      title: 'Upcoming Task! ⏰',
      body: 'It\'s almost time for: $taskName',
      scheduledDate: time,
      notificationDetails: notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id: id);
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
