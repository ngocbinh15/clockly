import 'package:clockly/features/task_home/controllers/task_home_controller.dart';
import 'package:get/get.dart';

class AnalysController extends GetxController {
  RxString timeFilter = 'This Week'.obs;

  RxInt touchedIdx = (-1).obs;
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

  void calcPercent() {
    final now = DateTime.now();

    final todayStart = DateTime(now.year, now.month, now.day);
    final todayEnd = DateTime(now.year, now.month, now.day, 23, 59, 59);

    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final startOfWeekDate = DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day);
    final endOfWeekDate = startOfWeekDate.add(const Duration(days: 6, hours: 23, minutes: 59, seconds: 59));

    // 👉 BƯỚC 1: LỌC DANH SÁCH TASK THEO THỜI GIAN ĐƯỢC CHỌN
    List<dynamic> filteredTasks = [];

    for (var task in taskHome.allTasks) {
      if (task.dueDate == null) continue;

      if (timeFilter.value == 'Today') {
        if (task.dueDate!.isAfter(todayStart.subtract(const Duration(seconds: 1))) &&
            task.dueDate!.isBefore(todayEnd.add(const Duration(seconds: 1)))) {
          filteredTasks.add(task);
        }
      } else if (timeFilter.value == 'This Week') {
        if (task.dueDate!.isAfter(startOfWeekDate.subtract(const Duration(seconds: 1))) &&
            task.dueDate!.isBefore(endOfWeekDate.add(const Duration(seconds: 1)))) {
          filteredTasks.add(task);
        }
      } else if (timeFilter.value == 'This Month') {
        if (task.dueDate!.year == now.year && task.dueDate!.month == now.month) {
          filteredTasks.add(task);
        }
      }
    }

    // Cập nhật tổng số lượng sau khi lọc
    filteredTotalCount.value = filteredTasks.length;

    // Nếu không có dữ liệu nào khớp thời gian, reset sạch về 0 tránh lỗi chia cho 0
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
    int weeklyDone = 0;
    int weeklyTotalInFilter = 0;

    for (var task in filteredTasks) {
      if (task.dueDate!.isAfter(startOfWeekDate.subtract(const Duration(seconds: 1))) &&
          task.dueDate!.isBefore(endOfWeekDate.add(const Duration(seconds: 1)))) {

        weeklyTotalInFilter++;
        if (task.status == 'completed') {
          weeklyDone++;
          int dayIndex = task.dueDate!.weekday - 1;
          tempTrend[dayIndex]++;
        }
      }
    }

    weeklyTrend.value = tempTrend;
    if (weeklyTotalInFilter == 0) {
      weeklyPercent.value = 0;
    } else {
      weeklyPercent.value = ((weeklyDone / weeklyTotalInFilter) * 100).round();
    }
  }
}