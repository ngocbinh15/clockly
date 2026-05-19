import 'package:clockly/core/theme/app_colors.dart';
import 'package:clockly/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Avatar extends StatelessWidget {
  Avatar({super.key, required this.avatarURL});

  String avatarURL;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.settings),
      child: CircleAvatar(
        radius: 30,
        backgroundColor: AppColors.grey,
        child: CircleAvatar(
          radius: 28,
          backgroundImage: NetworkImage(
            avatarURL
          ),
        ),
      ),
    );
  }
}