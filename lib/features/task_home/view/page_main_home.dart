import 'package:clockly/features/task_home/widgets/bottom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../core/theme/app_colors.dart';
import '../controllers/task_home_controller.dart';
import 'page_task.dart';
import 'page_team_task.dart';
import 'page_calendar.dart';
import 'page_analys.dart';
import '../widgets/custom_bottom_nav.dart';

class PageMainHome extends GetView<TaskHomeController> {
  const PageMainHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(
        index: controller.bottomNavIndex.value,
        children: [
          PageTask(),
          PageTeamTask(),
          PageCalendar(),
          PageAnalys(),
        ],
      )),

      floatingActionButton: FloatingActionButton(
          onPressed: () {
            BottomDialog.showAddTaskBottomSheet();
          },
          backgroundColor: AppColors.primary,
          elevation: 8,
          shape: const CircleBorder(),
          child: const HugeIcon(
            icon: HugeIcons.strokeRoundedAdd01,
            color: AppColors.secondary,
            strokeWidth: 1.5,
            size: 24,
          )
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,bottomNavigationBar: CustomBottomNav(),
    );
  }
}