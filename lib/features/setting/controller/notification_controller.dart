import 'package:clockly/core/services/auth_service.dart';
import 'package:clockly/core/services/notification_service.dart';
import 'package:clockly/features/auth/model/user_model.dart';
import 'package:clockly/features/setting/widgets/notification_dialog.dart';
import 'package:clockly/features/task_home/controllers/task_home_controller.dart';
import 'package:clockly/features/task_home/model/task.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationController extends GetxController {
  final notificationService = Get.find<NotificationService>();

  var isNotiEnabled = false.obs;
  var isDailyReminderOn = false.obs;
  var isTaskReminderOn = false.obs;

  void toggleTaskReminder(bool val) {
    isTaskReminderOn.value = val;
  }

  void toggleDailyReminder(bool val) {
    isDailyReminderOn.value = val;
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
    UserModel? currUser = Get.find<AuthService>().currentUser.value;

    if (currUser == null) {
      return;
    }

    List<TaskModel> taskList = Get.find<TaskHomeController>().allTasks;
  }
}
