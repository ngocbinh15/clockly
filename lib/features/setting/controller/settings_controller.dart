import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';


import '../../../core/components/app_alerts.dart';
import '../../../core/constants/app_message.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/utils/theme_helper.dart';
import '../../auth/controllers/auth_helper.dart';

class SettingsController extends GetxController {
  final authService = Get.find<AuthService>();
  final supabase = Supabase.instance.client;

  var userName = "".obs;
  var userEmail = "".obs;
  var avatarUrl = "".obs;

  var isNotiEnabled = false.obs;
  var selectedAppearance = "System".obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
    loadThemeSettings();
  }

  @override
  void onReady() {
    super.onReady();
    checkNotificationStatus();
  }

  Future<void> loadUserData() async {
    final user = supabase.auth.currentUser;
    if (user != null) {
      try {
        final data = authService.currentUser.value;

        userName.value = data?.fullName ?? "";
        userEmail.value = data?.email ?? "";
        avatarUrl.value = data?.avatarUrl ?? "";
      } catch (e) {
        AppAlerts.error(message: e.toString());
      }
    }
  }

  Future<void> updateAvatar() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    try {
      AuthHelper.showLoading();

      final File file = File(image.path);
      final user = supabase.auth.currentUser;
      if (user == null) throw 'User not found';

      final fileExtension = image.path.split('.').last;
      final fileName = '${user.id}_${DateTime.now().millisecondsSinceEpoch}.$fileExtension';

      await supabase.storage.from('images').upload(fileName, file);
      final publicUrl = supabase.storage.from('images').getPublicUrl(fileName);

      await supabase
          .from('profiles')
          .update({'avatar_url': publicUrl})
          .eq('id', user.id);

      avatarUrl.value = publicUrl;

      AuthHelper.hideLoading();

      Future.delayed(const Duration(milliseconds: 300), () {
        AppAlerts.success(message: AppMessages.avatarUpdated);
      });

    } catch (e) {
      AuthHelper.hideLoading();
      AppAlerts.error(message: e.toString());
    }
  }


  Future<void> checkNotificationStatus() async {
    isNotiEnabled.value = await Permission.notification.isGranted;
  }

  Future<void> handleNotificationTap() async {
    if (await Permission.notification.isGranted) {
      await openAppSettings();
    } else {
      PermissionStatus status = await Permission.notification.request();
      if (status.isGranted) {
        isNotiEnabled.value = true;
      } else {
        await openAppSettings();
      }
    }
    await checkNotificationStatus();
  }

  Future<void> loadThemeSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final mode = prefs.getString('theme_mode');
      if (mode == 'dark') {
        selectedAppearance.value = 'Dark';
      } else if (mode == 'light') {
        selectedAppearance.value = 'Light';
      } else {
        selectedAppearance.value = 'System';
      }
    } catch (e) {
      debugPrint("Error loading theme settings: $e");
    }
  }

  Future<void> changeAppearance(String mode) async {
    selectedAppearance.value = mode;
    try {
      final prefs = await SharedPreferences.getInstance();
      if (mode.toLowerCase() == 'dark') {
        Get.changeThemeMode(ThemeMode.dark);
        await prefs.setString('theme_mode', 'dark');
        ThemeHelper.isDark = true;
      } else if (mode.toLowerCase() == 'light') {
        Get.changeThemeMode(ThemeMode.light);
        await prefs.setString('theme_mode', 'light');
        ThemeHelper.isDark = false;
      } else {
        Get.changeThemeMode(ThemeMode.system);
        await prefs.remove('theme_mode');
        ThemeHelper.isDark = (WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark);
      }
    } catch (e) {
      AppAlerts.error(message: "Failed to save theme preference: $e");
    }
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
    '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  Future<void> launchSupportEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'binhnguyenngoc.it@gmail.com',
      query: encodeQueryParameters(<String, String>{
        'subject': 'Support request',
        'body': 'Dear customer service, \n\n',
      }),
    );

    try {
      await launchUrl(emailLaunchUri, mode: LaunchMode.externalApplication);
    } catch (e) {
      final Uri webGmail = Uri.parse(
          "https://mail.google.com/mail/?view=cm&fs=1&to=binhnguyenngoc.it@gmail.com&su=Support%20request"
      );

      try {
        await launchUrl(webGmail, mode: LaunchMode.externalApplication);
      } catch (webError) {
        AppAlerts.error(message: "Cannot open Email. Please check your internet or mail app.");
      }
    }
  }
}