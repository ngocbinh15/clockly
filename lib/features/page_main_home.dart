import 'package:clockly/features/task_home/widgets/bottom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

import '../core/theme/app_colors.dart';
import 'task_home/controllers/task_home_controller.dart';
import 'task_home/view/page_task.dart';
import 'leader_board/view/page_leader_board.dart';
import 'calendar/view/page_calendar.dart';
import 'analys/view/page_analys.dart';
import 'task_home/widgets/custom_bottom_nav.dart';

class PageMainHome extends GetView<TaskHomeController> {
  const PageMainHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(
        index: controller.bottomNavIndex.value,
        children: [
          PageTask(),
          PageCalendar(),
          PageAnalys(),
          PageLeaderBoard(),
        ],
      )),

      floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.resetStateController();

            BottomDialog.showAddTaskBottomSheet();
          },
          backgroundColor: AppColors.primary,
          elevation: 8,
          shape: const CircleBorder(),
          child: HugeIcon(
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