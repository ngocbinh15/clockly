import 'package:clockly/core/components/app_alerts.dart';
import 'package:clockly/core/constants/app_message.dart';
import 'package:clockly/core/services/ai_service.dart';
import 'package:clockly/core/services/auth_service.dart';
import 'package:clockly/core/services/notification_service.dart';
import 'package:clockly/core/theme/app_colors.dart';
import 'package:clockly/features/auth/controllers/auth_helper.dart';
import 'package:clockly/features/page_chat/model/local_chat_message.dart';
import 'package:clockly/features/setting/controller/notification_controller.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/utils/date_helper.dart';
import '../model/task.dart';
import '../model/task_category.dart';

import 'package:app_links/app_links.dart';
import 'package:clockly/features/page_chat/widgets/quick_task_dialog.dart';

class TaskHomeController extends GetxController {
  final String today = DateFormat('MMM dd, yyyy').format(DateTime.now());
  final currUser = Get.find<AuthService>().currentUser.value;
  RxString selected = "All Tasks".obs;

  final aiService = Get.find<AiService>();
  final notificationService = Get.find<NotificationService>();
  final notificationController = Get.find<NotificationController>();

  late ConfettiController confettiController;

  var isTyping = false.obs;
  var isGenerating = false.obs;
  var isGenerated = false.obs;
  String taskPrompt = "";
  var chatMessages = <LocalChatMessage>[].obs;

  var isSend = false.obs;

  RxString selectedAddTask = "General".obs;
  RxString selectedPriority = "Low".obs;

  final _supabase = Supabase.instance.client;
  final _authService = Get.find<AuthService>();

  RxList<String> selectedMemberIds = <String>[].obs;

  var isLoading = true.obs;
  final allTasks = <TaskModel>[].obs;
  var selectedCategory = TaskCategory.all.obs;

  RxInt bottomNavIndex = 0.obs;

  late TextEditingController nameController;
  late TextEditingController decriptionController;
  late TextEditingController dateController;
  late TextEditingController chatController;
  late TextEditingController quickTaskController;

  GlobalKey<FormState> formStateAddTask = GlobalKey<FormState>();

  RxMap<String, List<String>> taskMembersMap = <String, List<String>>{}.obs;

  late final RealtimeChannel _realtimeChannel;

  final _appLinks = AppLinks();

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
    confettiController = ConfettiController(
      duration: const Duration(seconds: 1),
    );
    nameController = TextEditingController();
    decriptionController = TextEditingController();
    dateController = TextEditingController();
    chatController = TextEditingController();
    quickTaskController = TextEditingController();
    _setupRealtimeTaskList();
    _initDeepLinkListener();
  }

  @override
  void onClose() {
    _supabase.removeChannel(_realtimeChannel);
    confettiController.dispose();
    nameController.dispose();
    decriptionController.dispose();
    dateController.dispose();
    chatController.dispose();
    quickTaskController.dispose();
    super.onClose();
  }

  void resetChatState() {
    chatController.clear();
    nameController.clear();
    decriptionController.clear();
    isTyping.value = false;
    isGenerating.value = false;
    isGenerated.value = false;
    isSend.value = false;
  }

  void _initDeepLinkListener() {
    _appLinks.uriLinkStream.listen((uri) {
      if (uri.scheme == 'clockly' && uri.host == 'addtask') {
        Future.delayed(const Duration(milliseconds: 300), () {
          Get.dialog(const QuickTaskDialog(), barrierDismissible: true);
        });
      }
    });
  }

  Future<void> generateTask() async {
    final inputText = nameController.text.trim();

    if (inputText.isEmpty || isGenerating.value || isGenerated.value) return;

    isGenerating.value = true;

    try {
      final newTask = await aiService.parseTaskFromText(inputText);
      if (newTask == null) return;

      nameController.text = newTask["title"] ?? inputText;
      decriptionController.text = newTask["description"] ?? "";
      dateController.text = newTask["due_date"] ?? "";
      selectedPriority.value = newTask["priority"] ?? "Low";
      selectedAddTask.value = newTask["category"] ?? "General";

      isGenerated.value = true;
    } catch (e) {
      AppAlerts.error(message: e.toString());
    } finally {
      isGenerating.value = false;
    }
  }

  Future<void> handleChatSubmission(String text) async {
    taskPrompt = text;

    chatMessages.add(LocalChatMessage(text: text, isSender: true));
    isGenerating.value = true;

    try {
      final result = await Future.wait([
        aiService.parseTaskFromText(text),
        Future.delayed(const Duration(milliseconds: 1500)),
      ]);

      final newTask = result[0] as Map<String, dynamic>?;

      if (newTask != null) {
        nameController.text = newTask["title"] ?? text;
        decriptionController.text = newTask["description"] ?? "";
        dateController.text = newTask["due_date"] ?? "";
        selectedPriority.value = newTask["priority"] ?? "Low";
        selectedAddTask.value = newTask["category"] ?? "General";

        chatMessages.add(
          LocalChatMessage(
            text: "Task added successfully! Here are the details ✨",
            isSender: false,
          ),
        );

        chatMessages.add(
          LocalChatMessage(
            text: "",
            isSender: false,
            isTaskCard: true,
            taskData: newTask,
          ),
        );

        await saveTaskFromChatSilent();
      }
    } catch (e) {
      AppAlerts.error(message: e.toString());
    } finally {
      isGenerating.value = false;
    }
  }

  Future<void> saveTaskFromChatSilent() async {
    try {
      DateTime? parsedDate;
      if (dateController.text.isNotEmpty) {
        try {
          parsedDate = DateFormat(
            'MMM dd, yyyy - hh:mm a',
          ).parse(dateController.text);
        } catch (_) {
          parsedDate = DateTime.tryParse(dateController.text);
        }
      }

      final userId = _authService.currentUser.value?.id;
      if (userId == null) {
        AppAlerts.error(message: "Your login session has expired.");
        return;
      }

      await _supabase.from('tasks').insert({
        'profile_id': userId,
        'title': nameController.text.trim(),
        'description': decriptionController.text.trim(),
        'status': 'pending',
        'priority': selectedPriority.value.toLowerCase(),
        'due_date': parsedDate?.toIso8601String(),
        'category': selectedAddTask.value.toLowerCase(),
      });

      await fetchTasks();
    } catch (e) {
      AppAlerts.error(message: e.toString());
    }
  }

  void _setupRealtimeTaskList() {
    _realtimeChannel = _supabase
        .channel('public:tasks')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'tasks',
          callback: (payload) {
            fetchTasks();
          },
        )
        .subscribe();
  }

  void prepareEditData(TaskModel task) {
    nameController.text = task.title;
    decriptionController.text = task.description ?? '';
    dateController.text = task.dueDate != null
        ? DateHelper.formatDateTime(task.dueDate!)
        : '';

    selectedPriority.value = task.priority.isNotEmpty
        ? "${task.priority[0].toUpperCase()}${task.priority.substring(1)}"
        : "Low";

    selectedAddTask.value = task.category.displayName;
  }

  Future<void> updateTask(String taskId) async {
    try {
      DateTime? parsedDate;
      if (dateController.text.isNotEmpty) {
        parsedDate = DateFormat(
          'MMM dd, yyyy - hh:mm a',
        ).parse(dateController.text);
      }

      AuthHelper.showLoading();

      await _supabase
          .from('tasks')
          .update({
            'title': nameController.text.trim(),
            'description': decriptionController.text.trim(),
            'priority': selectedPriority.value.toLowerCase(),
            'due_date': parsedDate?.toIso8601String(),
            'category': selectedAddTask.value.toLowerCase(),
          })
          .eq('id', taskId);

      await fetchTasks();

      AuthHelper.hideLoading();
      Get.back();
      AppAlerts.success(message: "Task updated successfully!");

      nameController.clear();
      decriptionController.clear();
      dateController.clear();
      selectedAddTask.value = "General";
      selectedPriority.value = "Low";
    } catch (e) {
      AuthHelper.hideLoading();
      AppAlerts.error(message: "Failed to update task: $e");
    }
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
        parsedDate = DateFormat(
          'MMM dd, yyyy - hh:mm a',
        ).parse(dateController.text);
      }

      isTyping.value = false;
      AuthHelper.showLoading();

      final taskResponse = await _supabase.from('tasks').insert({
        'profile_id': currUser!.id,
        'title': nameController.text.trim(),
        'description': decriptionController.text.trim(),
        'status': 'pending',
        'priority': selectedPriority.value.toLowerCase(),
        'due_date': parsedDate?.toIso8601String(),
        'category': selectedAddTask.value.toLowerCase(),
      }).select();

      final String newTaskId = taskResponse.first['id'];

      if (selectedMemberIds.isNotEmpty) {
        final List<Map<String, dynamic>> membersToInsert = selectedMemberIds
            .map((userId) {
              return {'task_id': newTaskId, 'profile_id': userId};
            })
            .toList();

        await _supabase.from('task_members').insert(membersToInsert);
      }

      await fetchTasks();
      AuthHelper.hideLoading();
      Get.back();
      AppAlerts.success(message: "Task created successfully!");

      resetStateController();
    } catch (e) {
      AuthHelper.hideLoading();
      AppAlerts.error(message: "$e");
    }
  }

  void resetStateController() {
    nameController.clear();
    decriptionController.clear();
    dateController.clear();
    selectedMemberIds.clear();
    selectedAddTask.value = "General";
    selectedPriority.value = "Medium";
  }

  List<TaskModel> get filteredTasks {
    if (selected.value == TaskCategory.all.displayName) {
      return allTasks;
    }
    return allTasks
        .where((task) => task.category.displayName == selected.value)
        .toList();
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

  List<TaskModel> get overdueTasks {
    final now = DateTime.now();
    final startOfToday = DateTime(now.year, now.month, now.day);
    return filteredTasks.where((task) {
      if (task.dueDate == null || task.status == 'completed') return false;
      return task.dueDate!.isBefore(startOfToday);
    }).toList();
  }

  List<TaskModel> get upcomingTasks {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    final endOfTomorrow = DateTime(
      tomorrow.year,
      tomorrow.month,
      tomorrow.day,
      23,
      59,
      59,
    );
    return filteredTasks.where((task) {
      if (task.dueDate == null) return false;
      return task.dueDate!.isAfter(endOfTomorrow);
    }).toList();
  }

  Future<void> fetchTasks() async {
    try {
      isLoading.value = true;
      final userId = _authService.currentUser.value?.id;
      if (userId == null) return;

      final myTasksResponse = await _supabase
          .from('tasks')
          .select()
          .eq('profile_id', userId);

      final teamTasksResponse = await _supabase
          .from('task_members')
          .select('tasks(*)')
          .eq('profile_id', userId);

      List<TaskModel> tempList = [];
      tempList.addAll(
        myTasksResponse.map((e) => TaskModel.fromMap(e)).toList(),
      );

      for (var row in teamTasksResponse) {
        if (row['tasks'] != null) {
          tempList.add(TaskModel.fromMap(row['tasks']));
        }
      }

      final uniqueTasks = {for (var t in tempList) t.id: t}.values.toList();

      uniqueTasks.sort((a, b) {
        if (a.dueDate == null && b.dueDate == null) return 0;
        if (a.dueDate == null) return 1;
        if (b.dueDate == null) return -1;
        return a.dueDate!.compareTo(b.dueDate!);
      });

      allTasks.value = uniqueTasks;

      if (uniqueTasks.isNotEmpty) {
        final List<String> taskIds = uniqueTasks.map((t) => t.id).toList();

        final membersResponse = await _supabase
            .from('task_members')
            .select('task_id, profiles(avatar_url)')
            .inFilter('task_id', taskIds);

        Map<String, List<String>> tempMembersMap = {};

        for (var row in membersResponse) {
          final String taskId = row['task_id'];
          final profile = row['profiles'];

          if (profile != null && profile['avatar_url'] != null) {
            final String avatarUrl = profile['avatar_url'];

            if (!tempMembersMap.containsKey(taskId)) {
              tempMembersMap[taskId] = [];
            }
            tempMembersMap[taskId]!.add(avatarUrl);
          }
        }

        taskMembersMap.value = tempMembersMap;
      } else {
        taskMembersMap.clear();
      }

      updateAllNotifications();
    } catch (e) {
      AppAlerts.error(message: "Failed to load tasks: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateAllNotifications() async {
    await notificationService.clearAllData();

    await notificationController.createAllTasksNotification();
    await notificationController.createSingleTaskNotification();
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

  Future<void> deleteTask(TaskModel task) async {
    allTasks.removeWhere((element) => element.id == task.id);

    try {
      await _supabase.from('tasks').delete().eq('id', task.id);
      notificationService.cancelNotification(task.id.hashCode);
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
    return DateFormat('MMM dd, hh:mm a').format(date);
  }

  void playConfetti() {
    confettiController.stop();
    confettiController.play();
  }

  Color getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return Colors.redAccent;
      case 'medium':
        return Colors.orangeAccent;
      case 'low':
        return Colors.blueAccent;
      default:
        return Colors.transparent;
    }
  }

  RxInt currentCategoryIndex = 0.obs;
  RxDouble slideDirection = 1.0.obs;

  void changeCategory(String categoryName, int newIndex) {
    if (newIndex > currentCategoryIndex.value) {
      slideDirection.value = 1.0;
    } else if (newIndex < currentCategoryIndex.value) {
      slideDirection.value = -1.0;
    }

    selected.value = categoryName;
    currentCategoryIndex.value = newIndex;
  }

  Future<void> processQuickTask() async {
    final text = quickTaskController.text.trim();
    if (text.isEmpty) return;

    Get.back();

    nameController.text = text;
    quickTaskController.clear();

    AppAlerts.success(
      message: "AI is analyzing your task",
      title: "Processing...",
      color: AppColors.primary.withValues(alpha: 0.5),
    );

    await handleChatSubmission(text);

    AppAlerts.success(message: "Task added to your list.");

    resetStateController();
  }
}
