import 'package:clockly/core/theme/app_colors.dart';
import 'package:clockly/features/task_home/controllers/task_home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Avatar extends StatelessWidget {
  Avatar({super.key});
  final controller = Get.find<TaskHomeController>();

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 30,
      backgroundColor: AppColors.grey,
      child: CircleAvatar(
        radius: 28,
        backgroundImage: NetworkImage(
          controller.currUser!.avatarUrl,
        ),
      ),
    );
  }
}