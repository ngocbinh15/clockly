import 'package:clockly/core/components/text_heading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/auth_service.dart';
import '../controllers/attendance_controller.dart';

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
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Column(
            children: [
              TextHeading(textHeading: currUser.id),
              TextHeading(textHeading: currUser.fullName),
              TextHeading(textHeading: currUser.totalPoints.toString()),
              TextHeading(textHeading: currUser.email),
              ElevatedButton(
                  onPressed: () => authService.logout(),
                  child: const Text("Sign out")
              ),
              const Spacer(),
            ],
          ),
        );
      }),
    );
  }
}