import 'dart:io';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
class SettingsController extends GetxController {
  String userName = "";
  String userEmail = "";
  String avatarUrl = "";

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
  }
}