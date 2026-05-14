import 'package:clockly/features/task_home/controllers/task_home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget {
  CustomAppBar({super.key});

  final controller = Get.find <TaskHomeController>();

  @override
  Widget build(BuildContext context) {
    return Row (
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text (controller.today, style: TextStyle(

            ),)
          ],
        )
      ],
    );
  }
}
