import 'package:clockly/core/components/app_alerts.dart';
import 'package:clockly/core/constants/app_message.dart';
import 'package:clockly/core/services/auth_service.dart';
import 'package:clockly/features/auth/controllers/auth_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/utils/date_helper.dart';
import '../model/task.dart';
import '../model/task_category.dart';

class TaskHomeController extends GetxController{
  final String today = DateFormat('MMM dd, yyyy').format(DateTime.now());
  final currUser = Get.find<AuthService>().currentUser.value;
  RxString selected = "All Tasks".obs;

  RxString selectedAddTask = "General".obs;
  RxString selectedPriority = "Low".obs;

  final _supabase = Supabase.instance.client;
  final _authService = Get.find<AuthService>();

  RxList<String> selectedMemberIds = <String>[].obs;

  var isLoading = true.obs;
  var allTasks = <TaskModel>[].obs;
  var selectedCategory = TaskCategory.all.obs;

  RxInt bottomNavIndex = 0.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController decriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  GlobalKey <FormState> formStateAddTask = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  void toggleMemberSelection(String userId) {
    if (selectedMemberIds.contains(userId)) {
      selectedMemberIds.remove(userId);
    } else {
      selectedMemberIds.add(userId);
    }
  }

  Future<void> saveTask() async {
    try {
      DateTime? parsedDate;
      if (dateController.text.isNotEmpty) {
        parsedDate = DateFormat('MMM dd, yyyy - hh:mm a').parse(dateController.text);
      }

      AuthHelper.showLoading();

      final taskResponse = await _supabase.from('tasks').insert({
        'profile_id': currUser!.id,
        'title': nameController.text.trim(),
        'description': decriptionController.text.trim(),
        'status': 'pending',
        'priority': selectedPriority.value.toLowerCase(),
        'due_date': parsedDate?.toIso8601String(),
        'category': selectedAddTask.value.toLowerCase()
      }).select();

      final String newTaskId = taskResponse.first['id'];

      if (selectedMemberIds.isNotEmpty) {
        final List<Map<String, dynamic>> membersToInsert = selectedMemberIds.map((userId) {
          return {
            'task_id': newTaskId,
            'profile_id': userId,
          };
        }).toList();

        await _supabase.from('task_members').insert(membersToInsert);
      }

      fetchTasks();
      AuthHelper.hideLoading();
      Get.back();
      AppAlerts.success(message: "Task created successfully!");

      nameController.clear();
      decriptionController.clear();
      dateController.clear();
      selectedMemberIds.clear();
      selectedAddTask.value = "General";
      selectedPriority.value = "Medium";

    } catch (e) {
      AuthHelper.hideLoading();
      AppAlerts.error(message: "$e");
    }
  }

  List<TaskModel> get filteredTasks {
    if (selected.value == TaskCategory.all.displayName) {
      return allTasks;
    }
    return allTasks.where((task) => task.category.displayName == selected.value).toList();
  }

  List<TaskModel> get todayTasks {
    final now = DateTime.now();
    return filteredTasks.where((task) {
      if (task.dueDate == null) return false;
      return task.dueDate!.year == now.year &&
          task.dueDate!.month == now.month &&
          task.dueDate!.day == now.day;
    }).toList();
  }

  List<TaskModel> get tomorrowTasks {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return filteredTasks.where((task) {
      if (task.dueDate == null) return false;
      return task.dueDate!.year == tomorrow.year &&
          task.dueDate!.month == tomorrow.month &&
          task.dueDate!.day == tomorrow.day;
    }).toList();
  }

  Future<void> fetchTasks() async {
    try {
      isLoading.value = true;
      final userId = _authService.currentUser.value?.id;
      if (userId == null) return;

      final response = await _supabase
          .from('tasks')
          .select()
          .eq('profile_id', userId)
          .order('due_date', ascending: true);

      allTasks.value = response.map((e) => TaskModel.fromMap(e)).toList();
    } catch (e) {
      AppAlerts.error(message: "$e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> toggleTaskStatus(TaskModel task) async {
    final newStatus = task.status == 'completed' ? 'pending' : 'completed';

    final index = allTasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      final updatedTask = TaskModel(
        id: task.id,
        profileId: task.profileId,
        title: task.title,
        description: task.description,
        category: task.category,
        dueDate: task.dueDate,
        createdAt: task.createdAt,
        priority: task.priority,
        status: newStatus,
      );
      allTasks[index] = updatedTask;
    }

    try {
      await _supabase
          .from('tasks')
          .update({'status': newStatus})
          .eq('id', task.id);
    } catch (e) {
      AppAlerts.error(message: "$e");
      fetchTasks();
    }
  }

  Future<void> deleteTask (TaskModel task) async {
    allTasks.removeWhere(
          (element) => element.id == task.id,
    );

    try {
      await _supabase
          .from('tasks')
          .delete()
          .eq('id', task.id);

      AppAlerts.success(message: AppMessages.deleteSuccess);

    } catch (e) {
      AppAlerts.error(message: "$e");
    }
  }

  String getGreetingText() {
    final hour = DateTime.now().hour;

    if (hour >= 18) return "Good Evening";
    if (hour >= 12) return "Good Afternoon";
    return "Good Morning";
  }

  void updateDueDate(DateTime date) {
    dateController.text = DateHelper.formatDateTime(date);
  }

  String formatTime(DateTime? date) {
    if (date == null) return "No time";
    final hour = date.hour;
    final minute = date.minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'PM' : 'AM';
    final formattedHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return "$formattedHour:$minute $period";
  }
}