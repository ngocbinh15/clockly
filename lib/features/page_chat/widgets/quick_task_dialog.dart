import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:clockly/core/constants/app_size.dart';
import 'package:clockly/core/theme/app_colors.dart';
import 'package:clockly/core/utils/theme_helper.dart';

import 'quick_task_header.dart';
import 'quick_task_input.dart';

class QuickTaskDialog extends StatelessWidget {
  const QuickTaskDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDark = ThemeHelper.isDark;
      final bgColor = isDark ? AppColors.secondary : Colors.white;

      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        elevation: 10,
        shadowColor: Colors.black.withValues(alpha: 0.1),
        backgroundColor: bgColor,
        child: const Padding(
          padding: EdgeInsets.all(AppSizes.p24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              QuickTaskHeader(),
              SizedBox(height: AppSizes.p20),
              QuickTaskInput(),
            ],
          ),
        ),
      );
    });
  }
}
