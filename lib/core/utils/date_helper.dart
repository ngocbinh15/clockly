import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:clockly/core/theme/app_colors.dart';

class DateHelper {
  static String formatDateTime(DateTime date) {
    return DateFormat('MMM dd, yyyy - hh:mm a').format(date);
  }

  static Future<DateTime?> showCustomDateTimePicker(BuildContext context) async {
    FocusScope.of(context).unfocus();

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: AppColors.secondary,
              onSurface: Colors.black87,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: AppColors.primary),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate == null) return null;

    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black87,
            ),

            timePickerTheme: TimePickerThemeData(
              backgroundColor: Colors.white,

              hourMinuteShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),

              dayPeriodShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),

              dayPeriodColor: Colors.grey.shade200,

              dayPeriodTextColor: Colors.black87,

              dayPeriodBorderSide: BorderSide.none,

              dayPeriodTextStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),

              dialHandColor: AppColors.primary,
              dialBackgroundColor: Colors.grey.shade100,

              hourMinuteColor: WidgetStateColor.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return AppColors.primary;
                }
                return Colors.grey.shade200;
              }),

              hourMinuteTextColor: WidgetStateColor.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return Colors.white;
                }
                return Colors.black87;
              }),
            ),
          ),
          child: child!,
        );
      },
    );

    final TimeOfDay finalTime = pickedTime ?? TimeOfDay.now();

    print("ALOALAOALAOAA: ${finalTime.hour}:${finalTime.minute}");

    return DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      finalTime.hour,
      finalTime.minute,
    );
  }

  static DateTime getTomorrow() {
    return DateTime.now().add(const Duration(days: 1));
  }

  static DateTime getIn3Days() {
    return DateTime.now().add(const Duration(days: 3));
  }

  static DateTime getThisSunday() {
    DateTime now = DateTime.now();
    int daysToSunday = 7 - now.weekday;
    if (daysToSunday == 0) daysToSunday = 7;
    return now.add(Duration(days: daysToSunday));
  }

  static DateTime getEndOfMonth() {
    DateTime now = DateTime.now();
    return DateTime(now.year, now.month + 1, 0);
  }
}