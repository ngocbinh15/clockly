import 'package:get/get.dart';
import '../../task_home/model/task.dart';
import '../../task_home/controllers/task_home_controller.dart';



class AnalysController extends GetxController {
  final _taskHomeController = Get.find<TaskHomeController>();

  RxBool get isLoading => _taskHomeController.isLoading;

  var totalCount = 0.obs;
  var completedCount = 0.obs;
  var pendingCount = 0.obs;
  var overdueCount = 0.obs;

  var weeklyProductivity = <double>[0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0].obs;

  @override
  void onInit() {
    super.onInit();
    calculateAnalytics();
    ever(_taskHomeController.allTasks, (_) => calculateAnalytics());
  }

  void calculateAnalytics() {
    final List<TaskModel> srcTasks = _taskHomeController.allTasks.value;
    if (srcTasks.isEmpty) {
      totalCount.value = 0;
      completedCount.value = 0;
      pendingCount.value = 0;
      overdueCount.value = 0;
      weeklyProductivity.value = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
      return;
    }

    totalCount.value = srcTasks.length;

    completedCount.value = srcTasks.where((t) {
      final s = t.status.trim().toLowerCase();
      return s == 'completed';
    }).length;

    pendingCount.value = srcTasks.where((t) {
      final s = t.status.trim().toLowerCase();
      return s == 'pending';
    }).length;

    overdueCount.value = srcTasks.where((t) {
      final s = t.status.trim().toLowerCase();
      return s == 'overdue';
    }).length;

    List<double> weekCounts = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];

    final DateTime now = srcTasks.map((t) => t.dueDate ?? t.createdAt).reduce((a, b) => a.isAfter(b) ? a : b);
    final DateTime startOfToday = DateTime(now.year, now.month, now.day);

    final int currentWeekday = now.weekday; // 1: Mon -> 7: Sun
    final DateTime mondayOfThisWeek = startOfToday.subtract(Duration(days: currentWeekday - 1));
    final DateTime sundayOfThisWeek = mondayOfThisWeek.add(const Duration(days: 6, hours: 23, minutes: 59, seconds: 59));

    for (var task in srcTasks) {
      if (task.status.trim().toLowerCase() == 'completed' && task.dueDate != null) {
        final taskDate = task.dueDate!;

        if ((taskDate.isAfter(mondayOfThisWeek) || taskDate.isAtSameMomentAs(mondayOfThisWeek)) &&
            (taskDate.isBefore(sundayOfThisWeek) || taskDate.isAtSameMomentAs(sundayOfThisWeek))) {

          int dayIndex = taskDate.weekday - 1;
          if (dayIndex >= 0 && dayIndex < 7) {
            weekCounts[dayIndex] += 1.0;
          }
        }
      }
    }

    weeklyProductivity.value = weekCounts;
  }
}