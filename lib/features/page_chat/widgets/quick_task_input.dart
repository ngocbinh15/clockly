import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:clockly/core/constants/app_size.dart';
import 'package:clockly/core/theme/app_colors.dart';
import 'package:clockly/core/utils/theme_helper.dart';
import 'package:clockly/features/task_home/controllers/task_home_controller.dart';

class QuickTaskInput extends GetView<TaskHomeController> {
  const QuickTaskInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDark = ThemeHelper.isDark;
      final borderColor = isDark ? AppColors.grey.withValues(alpha: 0.2) : const Color(0xFFCBD5E1);

      return TextField(
        controller: controller.quickTaskController,
        minLines: 1,
        maxLines: 4,
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.done,
        onSubmitted: (_) => controller.processQuickTask(),
        style: GoogleFonts.inter(
          color: isDark ? Colors.white : Colors.black87,
          fontSize: 14,
        ),
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: isDark ? Colors.transparent : Colors.grey.withValues(alpha: 0.03),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: borderColor, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: AppColors.primary, width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: borderColor, width: 1.5),
          ),
          hintText: "What's on your mind?",
          hintStyle: GoogleFonts.inter(color: Colors.grey, fontSize: 14),
          contentPadding: const EdgeInsets.symmetric(horizontal: AppSizes.p20, vertical: AppSizes.p16),
          
          suffixIconConstraints: const BoxConstraints(minHeight: 48, minWidth: 48),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: AppSizes.p8),
            child: IconButton(
              icon: HugeIcon(
                icon: HugeIcons.strokeRoundedSent,
                color: AppColors.primary,
              ),
              onPressed: () => controller.processQuickTask(),
            ),
          ),
        ),
      );
    });
  }
}