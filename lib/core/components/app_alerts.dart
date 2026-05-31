import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../constants/app_message.dart';

class AppAlerts {
  static void success({
    String title = AppMessages.success,
    Color? color,
    required String message,
  }) {
    final overlayState = Get.key.currentState?.overlay;

    if (overlayState == null) return;

    showTopSnackBar(
      overlayState,
      Material(
        color: Colors.transparent,
        child: AwesomeSnackbarContent(
          title: title,
          message: message,
          contentType: ContentType.success,
        ),
      ),
      displayDuration: const Duration(milliseconds: 600),
      animationDuration: const Duration(milliseconds: 1200),
    );
  }

  static void error({
    String title = AppMessages.error,
    String message = AppMessages.defaultError,
  }) {
    final overlayState = Get.key.currentState?.overlay;

    if (overlayState == null) return;

    showTopSnackBar(
      overlayState,
      Material(
        color: Colors.transparent,
        child: AwesomeSnackbarContent(
          title: title,
          message: message,
          contentType: ContentType.failure,
        ),
      ),
      displayDuration: const Duration(milliseconds: 600),
      animationDuration: const Duration(milliseconds: 1200),
    );
  }

  static void warning({
    String title = AppMessages.warning,
    required String message,
  }) {
    final overlayState = Get.key.currentState?.overlay;

    if (overlayState == null) return;

    showTopSnackBar(
      overlayState,
      Material(
        color: Colors.transparent,
        child: AwesomeSnackbarContent(
          title: title,
          message: message,
          contentType: ContentType.warning,
        ),
      ),
      displayDuration: const Duration(milliseconds: 600),
      animationDuration: const Duration(milliseconds: 1200),
    );
  }

  static void show({
    required String title,
    required String message,
    required ContentType type,
  }) {
    final overlayState = Get.key.currentState?.overlay;

    if (overlayState == null) return;

    showTopSnackBar(
      overlayState,
      Material(
        color: Colors.transparent,
        child: AwesomeSnackbarContent(
          title: title,
          message: message,
          contentType: type,
        ),
      ),
      displayDuration: const Duration(milliseconds: 700),
      animationDuration: const Duration(milliseconds: 500),
    );
  }
}
