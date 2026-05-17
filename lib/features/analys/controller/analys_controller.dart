import 'package:clockly/features/task_home/controllers/task_home_controller.dart';
import 'package:get/get.dart';

class AnalysController extends GetxController {
  RxInt touchedIdx = (-1).obs;
  RxInt latePercent = 30.obs;
  RxInt pendingPercent = 30.obs;
  RxInt donePercent = 40.obs;

  RxInt doneCount = 0.obs;
  RxInt lateCount = 0.obs;
  RxInt pendingCount = 0.obs;

  RxInt weeklyPercent = 0.obs;

  final taskHome = Get.find<TaskHomeController>();

  @override
  void onInit() {
    super.onInit();
    ever(taskHome.allTasks, (callback) {
      calcPercent();
    });
  }

  void calcPercent() {
    final totalTask = taskHome.allTasks.length;

    if (totalTask == 0) {
      latePercent.value = 0;
      pendingPercent.value = 0;
      donePercent.value = 0;
      weeklyPercent.value = 0;
      return;
    }

    doneCount.value = 0;
    lateCount.value = 0;
    pendingCount.value = 0;

    final now = DateTime.now();

    for (var task in taskHome.allTasks) {
      if (task.status == 'completed') {
        doneCount++;
      } else if (task.dueDate != null && task.dueDate!.isBefore(now)) {
        lateCount.value++;
      } else {
        pendingCount.value++;
      }
    }

    donePercent.value = ((doneCount.value / totalTask) * 100).round();
    latePercent.value = ((lateCount.value / totalTask) * 100).round();
    pendingPercent.value = 100 - donePercent.value - latePercent.value;

    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6, hours: 23, minutes: 59));

    int weeklyTotal = 0;
    int weeklyDone = 0;

    for (var task in taskHome.allTasks) {
      if (task.dueDate != null &&
          task.dueDate!.isAfter(startOfWeek.subtract(const Duration(seconds: 1))) &&
          task.dueDate!.isBefore(endOfWeek.add(const Duration(seconds: 1)))) {

        weeklyTotal++;
        if (task.status == 'completed') {
          weeklyDone++;
        }
      }
    }

    if (weeklyTotal == 0) {
      weeklyPercent.value = 0;
    } else {
      weeklyPercent.value = ((weeklyDone / weeklyTotal) * 100).round();
    }
  }
}