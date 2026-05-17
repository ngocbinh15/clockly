import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:clockly/features/task_home/controllers/task_home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../core/theme/app_colors.dart';

class CustomBottomNav extends StatelessWidget {
  CustomBottomNav({super.key});

  final controller = Get.find<TaskHomeController>();

  final iconList = [
    HugeIcons.strokeRoundedHome01,
    HugeIcons.strokeRoundedUserGroup,
    HugeIcons.strokeRoundedCalendar04,
    HugeIcons.strokeRoundedAnalysisTextLink,
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AnimatedBottomNavigationBar.builder(
        itemCount: iconList.length,
        activeIndex: controller.bottomNavIndex.value,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        backgroundColor: AppColors.secondary,
        height: 60,
        shadow: BoxShadow(
          color: Colors.black.withValues(alpha: 0.15),
          blurRadius: 10,
        ),
        tabBuilder: (int index, bool isActive) {
          final color = isActive ? AppColors.primary : AppColors.grey;
          return Center(
            child: HugeIcon(
              icon: iconList[index],
              color: color,
              size: 24,
            ),
          );
        },
        onTap: (index) {
          controller.bottomNavIndex.value = index;
        },
      );
    });
  }
}