import 'package:clockly/features/task_home/controllers/task_home_controller.dart';
import 'package:clockly/features/task_home/widgets/text_title_add_task.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../core/constants/app_size.dart';
import '../../../core/theme/app_colors.dart';
import '../model/task_category.dart';

class CustomActiomChip extends GetView<TaskHomeController> {
  CustomActiomChip({super.key});

  final Map<String, dynamic> selectedTheme = {
    "color": AppColors.primary.withValues(alpha: 0.12),
    "color_border": AppColors.primary,
    "style": GoogleFonts.inter(
      color: AppColors.primary,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
  };

  final Map<String, dynamic> noneSelectedTheme = {
    "color": AppColors.background,
    "color_border": AppColors.grey.withValues(alpha: 0.3),
    "style": GoogleFonts.inter(
      color: AppColors.grey,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextTitleAddTask(text: "Category"),

        SizedBox(height: AppSizes.p12),

        SizedBox(
          height: 45,
          child: Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: TaskCategory.values.length - 1,
              itemBuilder: (context, index) {
                final categoryEnum = TaskCategory.values
                    .where((element) => element.displayName != "All Tasks")
                    .toList()[index]
                    .displayName;
                final categoryIcon = TaskCategory.values[index].icon;

                return Obx(() {
                  final isSelected =
                      controller.selectedAddTask.value == categoryEnum;

                  Map<String, dynamic> theme = isSelected
                      ? selectedTheme
                      : noneSelectedTheme;
                  return Padding(
                    padding: const EdgeInsets.only(right: AppSizes.p12),
                    child: GestureDetector(
                      onTap: () {
                        controller.selectedAddTask.value = categoryEnum;
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.p24,
                          vertical: AppSizes.p8,
                        ),
                        decoration: BoxDecoration(
                          color: theme["color"],
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: theme["color_border"]),
                        ),
                        child: Center(
                          child: Row(
                            children: [
                              HugeIcon(
                                icon: categoryIcon,
                                color: theme["color_border"],
                              ),
                              SizedBox(width: AppSizes.p8),
                              Text(categoryEnum, style: theme["style"]),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
