import 'package:clockly/core/constants/app_size.dart';
import 'package:clockly/core/theme/app_colors.dart';
import 'package:clockly/features/task_home/controllers/task_home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/task_category.dart';

class CustomChoicesChip extends GetView<TaskHomeController> {
  const CustomChoicesChip({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> selectedTheme = {
      "color": AppColors.primary,
      "style": GoogleFonts.inter(
        color: AppColors.secondary,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    };

    final Map<String, dynamic> noneSelectedTheme = {
      "color": AppColors.secondary.withValues(alpha: 0.9),
      "style": GoogleFonts.inter(
        color: AppColors.third,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    };

    return SizedBox(
      height: 45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: TaskCategory.values.length,
        itemBuilder: (context, index) {
          final categoryEnum = TaskCategory.values[index].displayName;

          return Obx(() {
            final isSelected = controller.selected.value == categoryEnum;
            Map<String, dynamic> theme = isSelected
                ? selectedTheme
                : noneSelectedTheme;

            return Padding(
              padding: const EdgeInsets.only(right: AppSizes.p12),
              child: GestureDetector(
                onTap: () {
                  controller.selected.value = categoryEnum;
                  controller.changeCategory(categoryEnum, index);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.p24,
                    vertical: AppSizes.p8,
                  ),
                  decoration: BoxDecoration(
                    color: theme["color"],
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Center(
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 300),
                      style: theme["style"],
                      child: Text(categoryEnum),
                    ),
                  ),
                ),
              ),
            );
          });
        },
      ),
    );
  }
}
