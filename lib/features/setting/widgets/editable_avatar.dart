import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_size.dart';
import '../../../core/theme/app_colors.dart';
import '../controller/EditProfileController.dart';

class EditableAvatar extends GetView<EditProfileController> {
  const EditableAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.pickImage(),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.secondary, width: 4),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                )
              ],
            ),
            child: Obx(() {
              if (controller.selectedImagePath.value.isNotEmpty) {
                return CircleAvatar(
                  radius: 60,
                  backgroundImage: FileImage(File(controller.selectedImagePath.value)),
                );
              } else if (controller.avatarUrl.value.isNotEmpty) {
                return CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(controller.avatarUrl.value),
                );
              } else {
                return CircleAvatar(
                  radius: 60,
                  backgroundColor: AppColors.grey.withValues(alpha: 0.1),
                  child: Icon(Icons.person_rounded, size: 50, color: AppColors.grey),
                );
              }
            }),
          ),

          Container(
            padding: const EdgeInsets.all(AppSizes.p8),
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.secondary, width: 3),
            ),
            child: const Icon(Icons.camera_alt_rounded, color: Colors.white, size: 16),
          ),
        ],
      ),
    );
  }
}