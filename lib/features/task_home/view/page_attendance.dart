import 'package:clockly/core/components/text_heading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/auth_service.dart';
import '../../setting/views/page_settings.dart';
import '../controllers/attendance_controller.dart';

class PageTaskHome extends GetView<TaskHomeController> {
  PageTaskHome({super.key});

  final authService = Get.find<AuthService>();

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      _buildTaskView(),
      const Center(child: Text("Calendar Page", style: TextStyle(fontSize: 20))),
      const Center(child: Text("Focus Page", style: TextStyle(fontSize: 20))),
      PageSettings(),
    ];

    return Scaffold(
      body: Obx(() => pages[controller.currentIndex.value]),

      bottomNavigationBar: Obx(
            () => BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changePage,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xFF2E2CA7),
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.check_circle_outline),
              activeIcon: Icon(Icons.check_circle),
              label: "Tasks",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_outlined),
              activeIcon: Icon(Icons.calendar_today),
              label: "Calendar",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_outlined),
              activeIcon: Icon(Icons.bar_chart),
              label: "Focus",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              activeIcon: Icon(Icons.settings),
              label: "Settings",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskView() {
    return Obx(() {
      final currUser = authService.currentUser.value;

      if (currUser == null) {
        return const Center(child: CircularProgressIndicator());
      }

      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: double.infinity),
              const SizedBox(height: 20),
              TextHeading(textHeading: currUser.id),
              TextHeading(textHeading: currUser.fullName),
              TextHeading(textHeading: currUser.totalPoints.toString()),
              TextHeading(textHeading: currUser.email),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () => authService.logout(),
                  child: const Text("Sign out")
              ),
              const Spacer(),
            ],
          ),
        ),
      );
    });
  }
}