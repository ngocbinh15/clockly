import 'package:clockly/core/components/text_heading.dart';
import 'package:clockly/features/attendance/controllers/attendance_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/auth_service.dart';

class PageAttendance extends GetView<AttendanceController> {
  PageAttendance({super.key});

  final authService = Get.find<AuthService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Attendance Page"),
      ),
      body: Obx(() {
        final currUser = authService.currentUser.value;

        if (currUser == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            const Spacer(),
            TextHeading(textHeading: currUser.id),
            TextHeading(textHeading: currUser.full_name),
            TextHeading(textHeading: currUser.role),
            TextHeading(textHeading: currUser.email),
            ElevatedButton(
                onPressed: () => authService.logout(),
                child: const Text("Sign out")
            ),
            const Spacer(),
          ],
        );
      }),
    );
  }
}