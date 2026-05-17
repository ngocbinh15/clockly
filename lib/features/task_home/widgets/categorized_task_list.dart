import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../controllers/task_home_controller.dart';
import 'empty_task_widget.dart';
import 'task_list.dart';

class CategorizedTaskList extends GetView<TaskHomeController> {
  const CategorizedTaskList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.filteredTasks.isEmpty) {
        return EmptyTaskWidget(
          categoryName: controller.selected.value,
        );
      }

      if (controller.todayTasks.isEmpty && controller.tomorrowTasks.isEmpty) {
        return EmptyTaskWidget(
          categoryName: "${controller.selected.value} (No tasks for Today/Tomorrow)",
        );
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (controller.overdueTasks.isNotEmpty)
            TaskList(
              label: "OVERDUE",
              tasks: controller.overdueTasks,
              labelColor: AppColors.fouth,
            ),

          if (controller.todayTasks.isNotEmpty)
            TaskList(
              label: "TODAY",
              tasks: controller.todayTasks,
            ),

          if (controller.tomorrowTasks.isNotEmpty)
            TaskList(
              label: "TOMORROW",
              tasks: controller.tomorrowTasks,
            ),

          if (controller.upcomingTasks.isNotEmpty)
            TaskList(
              label: "UPCOMING",
              tasks: controller.upcomingTasks,
            ),
        ],
      );
    });
  }
}