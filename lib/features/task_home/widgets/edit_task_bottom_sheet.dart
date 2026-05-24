import 'package:clockly/core/components/primary_button.dart';
import 'package:clockly/core/constants/app_size.dart';
import 'package:clockly/core/theme/app_colors.dart';
import 'package:clockly/features/task_home/controllers/task_home_controller.dart';
import 'package:clockly/features/task_home/widgets/custom_actiom_chip.dart';
import 'package:clockly/features/task_home/widgets/pick_date_add_task.dart';
import 'package:clockly/features/task_home/widgets/priority_selector.dart';
import 'package:clockly/features/task_home/widgets/text_filed_add_task.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:clockly/core/utils/theme_helper.dart';

import '../model/task.dart';

class EditTaskBottomSheet extends GetView<TaskHomeController> {
  final TaskModel task;

  const EditTaskBottomSheet({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDark = ThemeHelper.isDark;
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.p24, vertical: AppSizes.p8),
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 70,
                height: 5,
                decoration: BoxDecoration(
                  color: AppColors.grey.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(height: AppSizes.p16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Edit Task", style: GoogleFonts.inter(
                    fontSize: 24,
                    fontWeight: FontWeight.w700
                )),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    padding: const EdgeInsets.all(AppSizes.p4),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.grey.withValues(alpha: 0.2)
                    ),
                    child: HugeIcon(
                      icon: HugeIcons.strokeRoundedCancel01,
                      size: 20,
                      color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.6),
                      strokeWidth: 2,
                    ),
                  ),
                )
              ],
            ),

            Form(
              key: controller.formStateAddTask,
              autovalidateMode: AutovalidateMode.disabled,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppSizes.p16),

                  TextFiledAddTask(),
                  CustomActiomChip(),
                  const SizedBox(height: AppSizes.p16),

                  Obx(() {
                    return PrioritySelector(
                      selectedPriority: controller.selectedPriority.value,
                      onChanged: (p0) => controller.selectedPriority.value = p0,
                    );
                  }),

                  const SizedBox(height: AppSizes.p16),
                  PickDateAddTask(),

                  const SizedBox(height: AppSizes.p24),
                  PrimaryButton(
                    text: "Save Changes",
                    onPressed: () async {
                      if (controller.formStateAddTask.currentState!.validate()) {
                        await controller.updateTask(task.id);
                      }
                    },
                    suffixIcon: HugeIcons.strokeRoundedArrowUp01,
                  )
                ],
              ),
            ),
            const SizedBox(height: AppSizes.p12),
          ],
        ),
      ),
    );
    });
  }
}