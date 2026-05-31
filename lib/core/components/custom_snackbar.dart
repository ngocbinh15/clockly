import 'package:clockly/core/components/app_alerts.dart';
import 'package:clockly/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class CustomSnackbar {
  static void snackbar(String title, String message, Color color) {
    ContentType type = ContentType.help;
    if (color == AppColors.green) {
      type = ContentType.success;
    } else if (color == AppColors.red) {
      type = ContentType.failure;
    }

    AppAlerts.show(
      title: title,
      message: message,
      type: type,
    );
  }
}
