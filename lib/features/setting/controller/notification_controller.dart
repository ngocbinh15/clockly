import 'package:clockly/core/services/notification_service.dart';
import 'package:clockly/features/setting/widgets/notification_dialog.dart';
import 'package:clockly/features/task_home/controllers/task_home_controller.dart';
import 'package:clockly/features/task_home/model/task.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationController extends GetxController {
  final notificationService = Get.find<NotificationService>();

  var isNotiEnabled = false.obs;
  var isDailyReminderOn = false.obs;
  var isTaskReminderOn = false.obs;

  @override
  void onInit() {
    super.onInit();

    _loadDaily();
    _loadSingle();
  }

  void _saveDaily() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    pref.setBool('isDailyReminderOn', isDailyReminderOn.value);
  }

  void _loadDaily() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    isDailyReminderOn.value = pref.getBool('isDailyReminderOn') ?? false;

    if (isDailyReminderOn.value) {
      await createAllTasksNotification();
    }
  }

  void _saveSingle() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    pref.setBool('isTaskReminderOn', isTaskReminderOn.value);
  }

  void _loadSingle() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    isTaskReminderOn.value = pref.getBool('isTaskReminderOn') ?? false;

    if (isTaskReminderOn.value) {
      await createSingleTaskNotification();
    }
  }

  void toggleDailyReminder(bool val) {
    isDailyReminderOn.value = val;

    if (isDailyReminderOn.value) {
      createAllTasksNotification();
    } else {
      notificationService.cancelAllDailyNotifications();
    }
    _saveDaily();
  }

  void toggleTaskReminder(bool val) {
    isTaskReminderOn.value = val;

    if (isTaskReminderOn.value) {
      createSingleTaskNotification();
    } else {
      notificationService.cancelAllSingleNotifications();
    }

    _saveSingle();
  }

  Future<void> requestPermissionNotification() async {
    var status = await Permission.notification.status;

    if (status.isPermanentlyDenied) {
      await openAppSettings();
      return;
    }

    if (status.isDenied) {
      status = await Permission.notification.request();
    }

    if (await Permission.scheduleExactAlarm.isDenied) {
      await Permission.scheduleExactAlarm.request();
    }

    if (status.isGranted) {
      Get.bottomSheet(
        NotificationDialog(),
        isScrollControlled: true,
        ignoreSafeArea: true,
      );
    }

    await checkNotificationStatus();
  }

  Future<void> checkNotificationStatus() async {
    isNotiEnabled.value = await Permission.notification.isGranted;
  }

  Future<void> createAllTasksNotification() async {
    if (!isDailyReminderOn.value) {
      return;
    }

    List<TaskModel> taskList = Get.find<TaskHomeController>().allTasks;

    Map<DateTime, List<TaskModel>> groupTasks = {};

    for (TaskModel task in taskList) {
      if (task.dueDate != null && task.status == 'pending') {
        final date = DateTime(
          task.dueDate!.year,
          task.dueDate!.month,
          task.dueDate!.day,
        );
        groupTasks.putIfAbsent(date, () => []).add(task);
      }
    }

    groupTasks.forEach((date, tasks) {
      notificationService.setDailySummaryNotification(
        id: date.hashCode,
        totalTasks: tasks.length,
        date: date,
      );
    });
  }

  Future<void> createSingleTaskNotification() async {
    if (!isTaskReminderOn.value) {
      return;
    }

    List<TaskModel> taskList = Get.find<TaskHomeController>().allTasks;

    List<Future<void>> notificationFutures = [];

    for (TaskModel task in taskList) {
      if (task.dueDate != null && task.status == 'pending') {
        notificationFutures.add(
          notificationService.setSingleTaskNotification(
            id: task.id.hashCode,
            taskName: task.title,
            date: task.dueDate!,
          ),
        );
      }
    }

    await Future.wait(notificationFutures);
  }
}
