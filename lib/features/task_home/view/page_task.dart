import 'package:clockly/core/constants/app_size.dart';
import 'package:clockly/core/theme/app_colors.dart';
import 'package:clockly/features/task_home/widgets/custom_app_bar.dart';
import 'package:clockly/features/task_home/widgets/custom_choices_chip.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/services/auth_service.dart';
import '../controllers/task_home_controller.dart';
import '../widgets/categorized_task_list.dart';

class PageTask extends GetView<TaskHomeController> {
  PageTask({super.key});

  final authService = Get.find<AuthService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        final currUser = authService.currentUser.value;

        if (currUser == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return RefreshIndicator(
          backgroundColor: AppColors.primary,
          color: AppColors.secondary,
          onRefresh: () async {
            await controller.fetchTasks();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + AppSizes.p12,
                left: AppSizes.p24,
                right: AppSizes.p24,
                bottom: AppSizes.p24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBar(),
                  const SizedBox(height: AppSizes.p24),

                  Text(
                    "My Tasks",
                    style: GoogleFonts.inter(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -1,
                    ),
                  ),
                  const SizedBox(height: AppSizes.p16),

                  CustomChoicesChip(),
                  const SizedBox(height: AppSizes.p32),

                  const CategorizedTaskList(),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}