import 'package:clockly/core/constants/app_size.dart';
import 'package:clockly/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackbar {
  static void snackbar (String title, String message, Color color) {
    Get.snackbar(
        title,
        message,
      colorText: AppColors.background,
      backgroundColor: color,
      duration: const Duration(seconds: 1),
      snackPosition: SnackPosition.TOP,
      padding: EdgeInsets.symmetric(vertical: AppSizes.p12, horizontal: AppSizes.p16)
    );
  }
}