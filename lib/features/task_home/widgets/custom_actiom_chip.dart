import 'package:clockly/features/task_home/controllers/task_home_controller.dart';
import 'package:clockly/features/task_home/widgets/chip_item.dart';
import 'package:clockly/features/task_home/widgets/text_title_add_task.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_size.dart';
import '../model/task_category.dart';

class CustomActionChip extends GetView<TaskHomeController> {
  CustomActionChip({super.key});

  final List<TaskCategory> categories = TaskCategory.values
      .where((cat) => cat != TaskCategory.all)
      .toList();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextTitleAddTask(text: "Category"),
        const SizedBox(height: AppSizes.p12),

        SizedBox(
          height: 46,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            padding: const EdgeInsets.symmetric(horizontal: 2),
            separatorBuilder: (context, index) =>
                const SizedBox(width: AppSizes.p12),
            itemBuilder: (context, index) {
              final category = categories[index];
              final categoryName = category.displayName;
              final categoryIcon = category.icon;

              return Obx(() {
                final isSelected =
                    controller.selectedAddTask.value == categoryName;

                return ChipItem(
                  controller: controller,
                  categoryName: categoryName,
                  icon: categoryIcon,
                  isSelected: isSelected,
                  isDark: isDark,
                );
              });
            },
          ),
        ),
      ],
    );
  }
}
