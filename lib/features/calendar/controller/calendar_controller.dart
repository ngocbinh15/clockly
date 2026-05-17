import 'package:clockly/core/components/app_alerts.dart';
import 'package:clockly/features/task_home/controllers/task_home_controller.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../core/services/auth_service.dart';

class CalendarController extends GetxController {
  final _supabase = Supabase.instance.client;
  final authService = Get.find<AuthService>();

  final taskHome = Get.find<TaskHomeController>();

  Rx<DateTime> focusedDay = DateTime.now().obs;
  Rx<DateTime?> selectedDay = DateTime.now().obs;
  Rx<CalendarFormat> calendarFormat = CalendarFormat.month.obs;

  RxList<DateTime> daysWithTasks = <DateTime>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchTaskDates();
  }

  Future<void> fetchTaskDates() async {
    try {
      final userId = authService.currentUser.value!.id;
      List<DateTime> loadedDates = [];

      final myTasksRes = await _supabase
          .from('tasks')
          .select('due_date')
          .eq('profile_id', userId)
          .not('due_date', 'is', null);

      for (var item in myTasksRes) {
        loadedDates.add(DateTime.parse(item['due_date'].toString()));
      }

      final coopTasksRes = await _supabase
          .from('task_members')
          .select('tasks!inner(due_date)')
          .eq('profile_id', userId);

      for (var item in coopTasksRes) {
        final taskData = item['tasks'];
        if (taskData != null && taskData['due_date'] != null) {
          loadedDates.add(DateTime.parse(taskData['due_date'].toString()));
        }
      }

      final uniqueDates = loadedDates.toSet().toList();

      daysWithTasks.assignAll(uniqueDates);

    } catch (e) {
      AppAlerts.error(message: "$e");
    }
  }

  void onDaySelected(DateTime selected, DateTime focused) {
    if (!isSameDay(selectedDay.value, selected)) {
      selectedDay.value = selected;
      focusedDay.value = focused;
    }
  }

  List<dynamic> getEventsForDay(DateTime day) {
    bool hasEvent = taskHome.allTasks.any((task) => isSameDay(task.dueDate, day));
    return hasEvent ? ['has_task'] : [];
  }
}