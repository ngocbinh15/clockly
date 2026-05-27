import 'package:clockly/core/constants/app_size.dart';
import 'package:clockly/core/theme/app_colors.dart';
import 'package:clockly/features/auth/validators/validate.dart';
import 'package:clockly/features/task_home/controllers/task_home_controller.dart';
import 'package:clockly/features/task_home/widgets/quick_chip.dart';
import 'package:clockly/features/task_home/widgets/text_title_add_task.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../core/utils/date_helper.dart';
import '../../../core/utils/theme_helper.dart';

class PickDateAddTask extends StatelessWidget {
  PickDateAddTask({super.key});

  final controller = Get.find<TaskHomeController>();

  Future<void> _handleSelectDate(BuildContext context) async {
    final DateTime? picked = await DateHelper.showCustomDateTimePicker(context);
    if (picked != null) {
      controller.updateDueDate(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDark = ThemeHelper.isDark;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextTitleAddTask(text: "Due Date"),
          const SizedBox(height: AppSizes.p8),

          TextFormField(
            controller: controller.dateController,
            readOnly: true,
            onTap: () => _handleSelectDate(context),
            validator: (value) => Validate.validDate(value),
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.white : Colors.black87,
            ),
            decoration: InputDecoration(
              hintText: "Select a date",
              hintStyle: GoogleFonts.inter(color: AppColors.grey),
              filled: true,
              fillColor: AppColors.grey.withValues(alpha: 0.1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.p12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSizes.p16,
                vertical: 14,
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.only(right: AppSizes.p12),
                child: HugeIcon(
                  icon: HugeIcons.strokeRoundedCalendar04,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
              suffixIconConstraints: const BoxConstraints(
                minWidth: AppSizes.p24,
                minHeight: AppSizes.p24,
              ),
            ),
          ),

          const SizedBox(height: AppSizes.p12),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                QuickChip(
                  label: "Tomorrow",
                  icon: Icons.wb_sunny_outlined,
                  onTap: () =>
                      controller.updateDueDate(DateHelper.getTomorrow()),
                ),
                QuickChip(
                  label: "In 3 days",
                  icon: Icons.next_plan_outlined,
                  onTap: () =>
                      controller.updateDueDate(DateHelper.getIn3Days()),
                ),
                QuickChip(
                  label: "This Sunday",
                  icon: Icons.weekend_outlined,
                  onTap: () =>
                      controller.updateDueDate(DateHelper.getThisSunday()),
                ),
                QuickChip(
                  label: "End of month",
                  icon: Icons.event_available_outlined,
                  onTap: () =>
                      controller.updateDueDate(DateHelper.getEndOfMonth()),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSizes.p12),
        ],
      );
    });
  }
}
