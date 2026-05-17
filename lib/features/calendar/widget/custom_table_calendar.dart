import 'package:clockly/core/constants/app_size.dart';
import 'package:clockly/features/calendar/controller/calendar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../core/theme/app_colors.dart';

class CustomTableCalendar extends GetView<CalendarController> {
  const CustomTableCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.p16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Obx(() {
        final trackingTasks = controller.taskHome.allTasks.length;

        return TableCalendar (
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: controller.focusedDay.value,
        calendarFormat: controller.calendarFormat.value,
        rowHeight: 56,

        eventLoader: controller.getEventsForDay,

        pageAnimationEnabled: true,
        pageJumpingEnabled: true,

        selectedDayPredicate: (day) => isSameDay(controller.selectedDay.value, day),

        onDaySelected: controller.onDaySelected,

        onFormatChanged: (format) {
          controller.calendarFormat.value = format;
        },
        onPageChanged: (focusedDay) {
          controller.focusedDay.value = focusedDay;
        },

        headerStyle: HeaderStyle(
          titleTextFormatter: (date, locale) =>
              DateFormat.yMMM(locale).format(date),
          formatButtonVisible: true,
          formatButtonDecoration: BoxDecoration(

          ),
          titleCentered: true,
          titleTextStyle: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
          leftChevronIcon: const Icon(Icons.chevron_left, color: Colors.black54),
          rightChevronIcon: const Icon(Icons.chevron_right, color: Colors.black54),
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: GoogleFonts.inter(color: Colors.grey, fontWeight: FontWeight.w600),
          weekendStyle: GoogleFonts.inter(color: Colors.grey, fontWeight: FontWeight.w600),
        ),
        calendarStyle: const CalendarStyle(
          outsideDaysVisible: false,
          defaultTextStyle: TextStyle(fontWeight: FontWeight.w500),
          weekendTextStyle: TextStyle(fontWeight: FontWeight.w500),
        ),

        calendarBuilders: CalendarBuilders(
          selectedBuilder: (context, date, events) {
            return Container(
              margin: const EdgeInsets.all(6.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.4),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                '${date.day}',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            );
          },

          todayBuilder: (context, date, events) {
            return Container(
              margin: const EdgeInsets.all(6.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Text(
                '${date.day}',
                style: GoogleFonts.inter(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            );
          },

          markerBuilder: (context, date, events) {
            if (events.isNotEmpty) {
              return Positioned(
                bottom: AppSizes.p4,
                child: Container(
                  height: AppSizes.p4,
                  width: AppSizes.p4,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary,
                  ),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      );}),
    );
  }
}