import 'package:clockly/core/theme/app_colors.dart';

import '../constants/app_message.dart';
import 'custom_snackbar.dart';

class AppAlerts {
  static void success({
    String title = AppMessages.success,
    required String message,
  }) {
    CustomSnackbar.snackbar(title, message, AppColors.green);
  }

  static void error({
    String title = AppMessages.error,
    String message = AppMessages.defaultError,
  }) {
    CustomSnackbar.snackbar(title, message, AppColors.red);
  }

  static void warning({
    String title = AppMessages.warning,
    required String message,
  }) {
    CustomSnackbar.snackbar(title, message, AppColors.orange);
  }
}