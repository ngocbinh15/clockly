import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const AndroidInitializationSettings android =
    AndroidInitializationSettings('@mipmap/launcher_icon');

    const InitializationSettings settings =
    InitializationSettings(android: android);

    await flutterLocalNotificationsPlugin.initialize(settings: settings);

    final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    if (androidImplementation != null) {
      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'task_high_priority_channel',
        'Task Reminder Notifications',
        description: 'Kênh hiển thị thông báo nhắc nhở công việc',
        importance: Importance.max,
      );

      await androidImplementation.createNotificationChannel(channel);

      await androidImplementation.requestNotificationsPermission();
    }
  }

  static Future<void> scheduleNotification({
    required int id,
    required String title,
    required DateTime scheduledDate,
  }) async {
    if (scheduledDate.isBefore(DateTime.now())) return;

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id: id,
      title: "Nhắc Nhở Lịch Sinh Hoạt",
      body: title,
      scheduledDate: tz.TZDateTime.from(scheduledDate, tz.local),
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'task_high_priority_channel',
          'Task Reminder Notifications',
          channelDescription: 'Kênh hiển thị thông báo nhắc nhở công việc',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
          enableVibration: true,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );

    debugPrint("[NotificationService] Đã đặt lịch nổ ngoài màn hình lúc: $scheduledDate");
  }
}