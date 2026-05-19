import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/components/app_alerts.dart';
import '../../../core/constants/app_message.dart';
import '../../../core/services/auth_service.dart';
import '../../auth/controllers/auth_helper.dart';

class SettingsController extends GetxController {
  final authService = Get.find<AuthService>();
  final supabase = Supabase.instance.client;

  var userName = "".obs;
  var userEmail = "".obs;
  var avatarUrl = "".obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
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
}