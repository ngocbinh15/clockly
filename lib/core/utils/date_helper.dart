import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:clockly/core/theme/app_colors.dart';
import 'package:clockly/core/utils/theme_helper.dart';

class DateHelper {
  static String formatDateTime(DateTime date) {
    return DateFormat('MMM dd, yyyy - hh:mm a').format(date);
  }

  static Future<DateTime?> showCustomDateTimePicker(
    BuildContext context,
  ) async {
    FocusScope.of(context).unfocus();
    final isDark = ThemeHelper.isDark;

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: isDark
              ? ThemeData.dark().copyWith(
                  colorScheme: const ColorScheme.dark(
                    primary: AppColors.primary,
                    onPrimary: Colors.white,
                    surface: Color(0xFF1E1E1E),
                    onSurface: Colors.white,
                    primaryContainer: Color(0xFF004AC6),
                    onPrimaryContainer: Colors.white,
                  ),
                  dialogBackgroundColor: const Color(0xFF1E1E1E),
                  datePickerTheme: DatePickerThemeData(
                    backgroundColor: const Color(0xFF1E1E1E),
                    headerBackgroundColor: AppColors.primary,
                    headerForegroundColor: Colors.white,
                    dayForegroundColor: WidgetStateProperty.resolveWith((
                      states,
                    ) {
                      if (states.contains(WidgetState.selected)) {
                        return Colors.white;
                      }
                      return Colors.white;
                    }),
                    dayBackgroundColor: WidgetStateProperty.resolveWith((
                      states,
                    ) {
                      if (states.contains(WidgetState.selected)) {
                        return AppColors.primary;
                      }
                      return Colors.transparent;
                    }),
                    todayForegroundColor: WidgetStateProperty.resolveWith((
                      states,
                    ) {
                      if (states.contains(WidgetState.selected)) {
                        return Colors.white;
                      }
                      return AppColors.primary;
                    }),
                    todayBorder: const BorderSide(
                      color: AppColors.primary,
                      width: 1.5,
                    ),
                    yearForegroundColor: WidgetStateProperty.resolveWith((
                      states,
                    ) {
                      if (states.contains(WidgetState.selected)) {
                        return Colors.white;
                      }
                      return Colors.white;
                    }),
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.primary,
                    ),
                  ),
                )
              : ThemeData.light().copyWith(
                  colorScheme: const ColorScheme.light(
                    primary: AppColors.primary,
                    onPrimary: Colors.white,
                    surface: Colors.white,
                    onSurface: Colors.black87,
                    primaryContainer: Color(0xFF004AC6),
                    onPrimaryContainer: Colors.white,
                  ),
                  dialogBackgroundColor: Colors.white,
                  datePickerTheme: DatePickerThemeData(
                    backgroundColor: Colors.white,
                    headerBackgroundColor: AppColors.primary,
                    headerForegroundColor: Colors.white,
                    dayForegroundColor: WidgetStateProperty.resolveWith((
                      states,
                    ) {
                      if (states.contains(WidgetState.selected)) {
                        return Colors.white;
                      }
                      return Colors.black87;
                    }),
                    dayBackgroundColor: WidgetStateProperty.resolveWith((
                      states,
                    ) {
                      if (states.contains(WidgetState.selected)) {
                        return AppColors.primary;
                      }
                      return Colors.transparent;
                    }),
                    todayForegroundColor: WidgetStateProperty.resolveWith((
                      states,
                    ) {
                      if (states.contains(WidgetState.selected)) {
                        return Colors.white;
                      }
                      return AppColors.primary;
                    }),
                    todayBorder: const BorderSide(
                      color: AppColors.primary,
                      width: 1.5,
                    ),
                    yearForegroundColor: WidgetStateProperty.resolveWith((
                      states,
                    ) {
                      if (states.contains(WidgetState.selected)) {
                        return Colors.white;
                      }
                      return Colors.black87;
                    }),
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.primary,
                    ),
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
          data: isDark
              ? ThemeData.dark().copyWith(
                  colorScheme: const ColorScheme.dark(
                    primary: AppColors.primary,
                    onPrimary: Colors.white,
                    surface: Color(0xFF1E1E1E),
                    onSurface: Colors.white,
                  ),
                  dialogBackgroundColor: const Color(0xFF1E1E1E),
                  timePickerTheme: TimePickerThemeData(
                    backgroundColor: const Color(0xFF1E1E1E),
                    hourMinuteShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    dayPeriodShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    dayPeriodColor: WidgetStateColor.resolveWith((states) {
                      if (states.contains(WidgetState.selected)) {
                        return AppColors.primary.withValues(alpha: 0.2);
                      }
                      return Colors.grey.shade800;
                    }),
                    dayPeriodTextColor: WidgetStateColor.resolveWith((states) {
                      if (states.contains(WidgetState.selected)) {
                        return AppColors.primary;
                      }
                      return Colors.white;
                    }),
                    dayPeriodBorderSide: BorderSide(
                      color: Colors.grey.shade700,
                      width: 1,
                    ),
                    dayPeriodTextStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    dialHandColor: AppColors.primary,
                    dialBackgroundColor: Colors.grey.shade900,
                    dialTextColor: WidgetStateColor.resolveWith((states) {
                      if (states.contains(WidgetState.selected)) {
                        return Colors.white;
                      }
                      return Colors.white;
                    }),
                    hourMinuteColor: WidgetStateColor.resolveWith((states) {
                      if (states.contains(WidgetState.selected)) {
                        return AppColors.primary;
                      }
                      return Colors.grey.shade800;
                    }),
                    hourMinuteTextColor: WidgetStateColor.resolveWith((states) {
                      if (states.contains(WidgetState.selected)) {
                        return Colors.white;
                      }
                      return Colors.white70;
                    }),
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.primary,
                    ),
                  ),
                )
              : ThemeData.light().copyWith(
                  colorScheme: const ColorScheme.light(
                    primary: AppColors.primary,
                    onPrimary: Colors.white,
                    surface: Colors.white,
                    onSurface: Colors.black87,
                  ),
                  dialogBackgroundColor: Colors.white,
                  timePickerTheme: TimePickerThemeData(
                    backgroundColor: Colors.white,
                    hourMinuteShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    dayPeriodShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    dayPeriodColor: WidgetStateColor.resolveWith((states) {
                      if (states.contains(WidgetState.selected)) {
                        return AppColors.primary.withValues(alpha: 0.15);
                      }
                      return Colors.grey.shade200;
                    }),
                    dayPeriodTextColor: WidgetStateColor.resolveWith((states) {
                      if (states.contains(WidgetState.selected)) {
                        return AppColors.primary;
                      }
                      return Colors.black87;
                    }),
                    dayPeriodBorderSide: BorderSide(
                      color: Colors.grey.shade300,
                      width: 1,
                    ),
                    dayPeriodTextStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    dialHandColor: AppColors.primary,
                    dialBackgroundColor: Colors.grey.shade100,
                    dialTextColor: WidgetStateColor.resolveWith((states) {
                      if (states.contains(WidgetState.selected)) {
                        return Colors.white;
                      }
                      return Colors.black87;
                    }),
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
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.primary,
                    ),
                  ),
                ),
          child: child!,
        );
      },
    );

    final TimeOfDay finalTime = pickedTime ?? TimeOfDay.now();


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
