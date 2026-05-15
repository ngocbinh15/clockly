import 'package:clockly/core/constants/app_size.dart';
import 'package:clockly/core/theme/app_colors.dart';
import 'package:clockly/features/task_home/controllers/task_home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'avatar.dart';

class CustomAppBar extends StatelessWidget {
  CustomAppBar({super.key});

  final controller = Get.find <TaskHomeController>();

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              controller.today,
              style: TextStyle(
                color: AppColors.third,
                fontSize: AppSizes.p16,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: AppSizes.p4),
            Text(
              controller.getGreetingText(),
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 25,
              ),
            ),
          ],
        ),
        Avatar(),
      ],
    );
  }
}
