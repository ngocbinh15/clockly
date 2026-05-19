import 'dart:ui';

import 'package:clockly/features/task_home/controllers/task_home_controller.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';

class AnalysisController extends GetxController {
  RxString timeFilter = 'This Month'.obs;

  RxInt touchedIdx = (-1).obs;
  RxInt touchedBarIdx = (-1).obs;

  RxInt latePercent = 0.obs;
  RxInt pendingPercent = 0.obs;
  RxInt donePercent = 0.obs;

  RxInt doneCount = 0.obs;
  RxInt lateCount = 0.obs;
  RxInt pendingCount = 0.obs;

  RxInt weeklyPercent = 0.obs;
  RxList<int> weeklyTrend = List.filled(7, 0).obs;

  RxInt filteredTotalCount = 0.obs;

  final taskHome = Get.find<TaskHomeController>();

  @override
  void onInit() {
    super.onInit();
    calcPercent();
    ever(taskHome.allTasks, (_) => calcPercent());
    ever(timeFilter, (_) => calcPercent());
  }

  bool isBetween(DateTime date, DateTime start, DateTime end) {
    return !date.isBefore(start) && !date.isAfter(end);
  }

  void calcPercent() {
    final now = DateTime.now();

    final todayStart = DateTime(now.year, now.month, now.day);
    final todayEnd = DateTime(now.year, now.month, now.day, 23, 59, 59);

    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final startOfWeekDate = DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day);
    final endOfWeekDate = startOfWeekDate.add(const Duration(days: 6, hours: 23, minutes: 59, seconds: 59));

    final filteredTasks = taskHome.allTasks.where((task) {
      if (task.dueDate == null) return false;

      switch (timeFilter.value) {
        case 'Today':
          return isBetween(task.dueDate!, todayStart, todayEnd);
        case 'This Week':
          return isBetween(task.dueDate!, startOfWeekDate, endOfWeekDate);
        case 'This Month':
          return task.dueDate!.year == now.year && task.dueDate!.month == now.month;
        default:
          return true;
      }
    }).toList();

    filteredTotalCount.value = filteredTasks.length;

    if (filteredTasks.isEmpty) {
      latePercent.value = 0;
      pendingPercent.value = 0;
      donePercent.value = 0;
      doneCount.value = 0;
      lateCount.value = 0;
      pendingCount.value = 0;
      weeklyPercent.value = 0;
      weeklyTrend.value = List.filled(7, 0);
      return;
    }

    int tempDone = 0;
    int tempLate = 0;
    int tempPending = 0;

    for (var task in filteredTasks) {
      if (task.status == 'completed') {
        tempDone++;
      } else if (task.dueDate!.isBefore(now)) {
        tempLate++;
      } else {
        tempPending++;
      }
    }

    doneCount.value = tempDone;
    lateCount.value = tempLate;
    pendingCount.value = tempPending;

    donePercent.value = ((tempDone / filteredTasks.length) * 100).round();
    latePercent.value = ((tempLate / filteredTasks.length) * 100).round();
    pendingPercent.value = 100 - donePercent.value - latePercent.value;

    List<int> tempTrend = List.filled(7, 0);
    int periodDone = 0;

    for (var task in filteredTasks) {
      DateTime localDue = task.dueDate!.toLocal();

      if (task.status == 'completed') {
        periodDone++;
      }
      tempTrend[localDue.weekday - 1]++;
    }

    weeklyTrend.value = tempTrend;

    if (filteredTasks.isEmpty) {
      weeklyPercent.value = 0;
    } else {
      weeklyPercent.value = ((periodDone / filteredTasks.length) * 100).round();
    }
  }

  String get chartCenterLabel {
    switch (touchedIdx.value) {
      case 0: return "Late";
      case 1: return "Pending";
      case 2: return "Completed";
      default: return "Total";
    }
  }

  String get chartCenterValue {
    switch (touchedIdx.value) {
      case 0: return "${lateCount.value}";
      case 1: return "${pendingCount.value}";
      case 2: return "${doneCount.value}";
      default: return "${filteredTotalCount.value}";
    }
  }

  Color get chartCenterColor {
    switch (touchedIdx.value) {
      case 0: return AppColors.contentLate;
      case 1: return AppColors.contentPending;
      case 2: return AppColors.contentDone;
      default: return AppColors.grey;
    }
  }
}