import 'package:clockly/core/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';

class TestNotification extends StatelessWidget {
  const TestNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () async {
                // final notification = Get.put(NotificationService());

                // await notification.sendNotification();
              },
              child: Text("Press Here!"),
            ),
          ),
        ],
      ),
    );
  }
}
