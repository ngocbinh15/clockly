import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:clockly/core/theme/app_colors.dart';

class DateHelper {
  static String formatDate(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }

  static Future<DateTime?> showCustomDatePicker(BuildContext context) async {
    FocusScope.of(context).unfocus();

    return await showDatePicker(
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
          ),
          child: child!,
        );
      },
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