import 'package:clockly/core/constants/app_size.dart';
import 'package:clockly/core/theme/app_colors.dart';
import 'package:clockly/features/task_home/controllers/calendar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:clockly/features/task_home/widgets/task_list.dart';
import 'package:dotted_border/dotted_border.dart';

class TodayTask extends GetView<CalendarController> {
  const TodayTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Tasks for Selected Day",
              style: GoogleFonts.inter(
                  color: Colors.black87,
                  fontSize: 20,
                  fontWeight: FontWeight.w700
              ),
            ),

            Obx(() {
              final selectedDate = controller.selectedDay.value;
              final currentTasks = controller.taskHome.allTasks.where(
                    (t) => isSameDay(t.dueDate, selectedDate),
              ).toList();

              return Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppSizes.p16, vertical: AppSizes.p4),
                  decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(16)
                  ),
                  child: Text(
                    "${currentTasks.length} tasks",
                    style: GoogleFonts.inter(
                        color: AppColors.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                    ),
                  )
              );
            }),
          ],
        ),

        const SizedBox(height: AppSizes.p12),

        Obx(() {
          final selectedDate = controller.selectedDay.value;
          final currentTasks = controller.taskHome.allTasks.where(
                (t) => isSameDay(t.dueDate, selectedDate),
          ).toList();

          if (currentTasks.isEmpty) {
            return Padding(
              padding: const EdgeInsets.only(top: AppSizes.p12),
              child: DottedBorder(
                options: CustomPathDottedBorderOptions(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  strokeWidth: 1.5,
                  dashPattern: const [8, 6],

                  customPath: (size) => Path()
                    ..addRRect(
                      RRect.fromRectAndRadius(
                        Rect.fromLTWH(0, 0, size.width, size.height),
                        const Radius.circular(24),
                      ),
                    ),
                ),

                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  color: Colors.transparent,
                  child: Center(
                    child: Text(
                      "That's all for today!",
                      style: GoogleFonts.inter(
                        color: AppColors.grey.withValues(alpha: 0.7),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }

          return TaskList(
            label: "",
            tasks: currentTasks,
          );
        }),
      ],
    );
  }
}