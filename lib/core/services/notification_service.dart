import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService extends GetxService {
  late AndroidInitializationSettings androidInitializationSettings;
  late InitializationSettings initializationSettings;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  late tz.Location location;

  List<String> totalDailyIds = [];
  List<String> totalSingleIds = [];

  @override
  void onInit() {
    super.onInit();
    _setupSettings();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    location = tz.getLocation('Asia/Ho_Chi_Minh');

    initialize();
    _loadStoredIds();
  }

  void _setupSettings() {
    androidInitializationSettings = const AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
    );
  }

  Future<void> initialize() async {
    await flutterLocalNotificationsPlugin.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: (details) {},
    );
  }

  Future<void> _loadStoredIds() async {
    final pref = await SharedPreferences.getInstance();
    totalDailyIds = pref.getStringList('totalDailyIds') ?? [];
    totalSingleIds = pref.getStringList('totalSingleIds') ?? [];
  }

  Future<void> _saveDailyIds() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setStringList('totalDailyIds', totalDailyIds);
  }

  Future<void> _saveSingleIds() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setStringList('totalSingleIds', totalSingleIds);
  }

  Future<void> setDailySummaryNotification({
    required int id,
    required int totalTasks,
    required DateTime date,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'daily_digest_channel',
      'Daily Summary',
      importance: Importance.max,
      priority: Priority.high,
    );

    final time = tz.TZDateTime(location, date.year, date.month, date.day, 8, 0);

    if (time.isBefore(tz.TZDateTime.now(location))) return;

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id: id,
      title: totalTasks > 0 ? 'Good morning! ☀️' : 'Relaxing day ahead! ☕',
      body: totalTasks > 0
          ? 'You have $totalTasks tasks waiting for today.'
          : 'No tasks scheduled for today. Enjoy your day!',
      scheduledDate: time,
      notificationDetails: const NotificationDetails(android: androidDetails),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );

    if (!totalDailyIds.contains(id.toString())) {
      totalDailyIds.add(id.toString());
      await _saveDailyIds();
    }
  }

  Future<void> setSingleTaskNotification({
    required int id,
    required String taskName,
    required DateTime date,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'single_task_channel',
      'Task Reminders',
      importance: Importance.max,
      priority: Priority.high,
    );

    final scheduledTime = tz.TZDateTime(
      location,
      date.year,
      date.month,
      date.day,
      date.hour,
      date.minute - 15,
    );

    if (scheduledTime.isBefore(tz.TZDateTime.now(location))) return;

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id: id,
      title: 'Upcoming Task! ⏰',
      body: 'It\'s almost time for: $taskName',
      scheduledDate: scheduledTime,
      notificationDetails: const NotificationDetails(android: androidDetails),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );

    if (!totalSingleIds.contains(id.toString())) {
      totalSingleIds.add(id.toString());
      await _saveSingleIds();
    }
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id: id);
    totalSingleIds.remove(id.toString());
    totalDailyIds.remove(id.toString());
    await _saveSingleIds();
    await _saveDailyIds();
  }

  Future<void> cancelAllSingleNotifications() async {
    if (totalSingleIds.isEmpty) return;

    final List<Future<void>> cancels = totalSingleIds
        .map((id) => flutterLocalNotificationsPlugin.cancel(id: int.parse(id)))
        .toList();

    await Future.wait(cancels);
    totalSingleIds.clear();
    await _saveSingleIds();
  }

  Future<void> cancelAllDailyNotifications() async {
    if (totalDailyIds.isEmpty) return;

    final List<Future<void>> cancels = totalDailyIds
        .map((id) => flutterLocalNotificationsPlugin.cancel(id: int.parse(id)))
        .toList();

    await Future.wait(cancels);
    totalDailyIds.clear();
    await _saveDailyIds();
  }

  Future<void> clearAllData() async {
    await flutterLocalNotificationsPlugin.cancelAll();
    totalSingleIds.clear();
    totalDailyIds.clear();
    await _saveSingleIds();
    await _saveDailyIds();
  }
}
