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
      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        switchInCurve: Curves.easeOutQuart,
        switchOutCurve: Curves.easeInQuart,

        layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
          return Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              ...previousChildren,
              if (currentChild != null) currentChild,
            ],
          );
        },

        transitionBuilder: (Widget child, Animation<double> animation) {
          final isIncoming = child.key == ValueKey<String>(controller.selected.value);

          final offset = isIncoming
              ? Offset(controller.slideDirection.value, 0.0)
              : Offset(-controller.slideDirection.value, 0.0);

          final slideAnimation = Tween<Offset>(
            begin: offset,
            end: Offset.zero,
          ).animate(animation);

          return SlideTransition(
            position: slideAnimation,
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
        child: _buildTaskListContent(),
      );
    });
  }

  Widget _buildTaskListContent() {
    final currentCategory = controller.selected.value;

    return Container(
      key: ValueKey<String>(currentCategory),
      child: _getFilteredView(currentCategory),
    );
  }

  Widget _getFilteredView(String currentCategory) {
    if (controller.filteredTasks.isEmpty) {
      return EmptyTaskWidget(
        categoryName: currentCategory,
      );
    }

    if (controller.todayTasks.isEmpty && controller.tomorrowTasks.isEmpty) {
      return EmptyTaskWidget(
        categoryName: "$currentCategory (No tasks for Today/Tomorrow)",
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
  }
}