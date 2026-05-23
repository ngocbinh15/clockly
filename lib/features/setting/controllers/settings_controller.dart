import 'dart:io';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
class SettingsController extends GetxController {
  String userName = "";
  String userEmail = "";
  String avatarUrl = "";
  List<String> appearanceList = ["dark", "light", "system"];
  String? selectedAppearance = "system";
  bool isNotiEnabled = false;

  final supabase = Supabase.instance.client;

  Future<void> loadUserData() async {
    try {
      final user = supabase.auth.currentUser;
      if (user != null) {
        final data = await supabase
            .from('profiles')
            .select()
            .eq('id', user.id)
            .single();

        userName = data['full_name'] ?? "Người dùng";
        userEmail = data['email'] ?? user.email ?? "";
        avatarUrl = data['avatar_url'] ?? "";
        update(["settings"]);
      }
    } catch (e) {
      print("Lỗi khi loadUserData: $e");
    }
  }

  @override
  void onReady() {
    super.onReady();
    loadUserData();
    checkNotificationStatus();
  }

  Future<void> checkNotificationStatus() async {
    if (await Permission.notification.isGranted) {
      isNotiEnabled = true;
    } else {
      isNotiEnabled = false;
    }
    update(['settings']);
  }

  Future<void> handleNotificationTap() async {
    if (await Permission.notification.isGranted) {
      await openAppSettings();
    } else {
      PermissionStatus status = await Permission.notification.request();

      if (status.isGranted) {
        isNotiEnabled = true;
      }
      if (status.isPermanentlyDenied || status.isDenied) {
        await openAppSettings();
      }
    }
    await checkNotificationStatus();
  }

  void changeAppearance(String? newValue) {
    if (newValue != null) {
      selectedAppearance = newValue;
      update(['settings']);
    }
  }
}
