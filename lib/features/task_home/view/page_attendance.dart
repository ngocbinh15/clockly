import 'package:clockly/core/components/text_heading.dart';
import 'package:clockly/core/constants/app_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/auth_service.dart';
import '../controllers/task_home_controller.dart';

class PageTaskHome extends GetView<TaskHomeController> {
  PageTaskHome({super.key});

  final authService = Get.find<AuthService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        final currUser = authService.currentUser.value;

        if (currUser == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
            left: AppSizes.p12,
            right: AppSizes.p12,
            bottom: AppSizes.p12,
          ),
          child: Column(
            children: [
              
            ],
          ),
        );
      }),
    );
  }
}