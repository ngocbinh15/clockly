import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/components/app_alerts.dart';
import '../../../core/constants/app_message.dart';
import '../../../core/services/auth_service.dart';
import '../../auth/controllers/auth_helper.dart';
import '../controller/settings_controller.dart';

class EditProfileController extends GetxController {
  final authService = Get.find<AuthService>();
  final supabase = Supabase.instance.client;

  late TextEditingController nameController;

  var avatarUrl = "".obs;
  var selectedImagePath = "".obs;

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    _loadCurrentUserData();
  }

  void _loadCurrentUserData() {
    final data = authService.currentUser.value;
    if (data != null) {
      nameController.text = data.fullName;
      avatarUrl.value = data.avatarUrl;
    }
  }

  Future<void> pickImage() async {
    try {
      AuthHelper.showLoading();

      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      AuthHelper.hideLoading();

      if (image != null) {
        selectedImagePath.value = image.path;
      }

    } catch (e) {
      AuthHelper.hideLoading();

      AppAlerts.error(message: "Cannot open gallery: $e");
    }
  }

  Future<void> saveProfile() async {
    try {
      AuthHelper.showLoading();
      final user = supabase.auth.currentUser;
      if (user == null) throw 'User not found';

      String finalAvatarUrl = avatarUrl.value;

      if (selectedImagePath.value.isNotEmpty) {
        final File file = File(selectedImagePath.value);
        final fileExtension = selectedImagePath.value.split('.').last;
        final fileName = '${user.id}_${DateTime.now().millisecondsSinceEpoch}.$fileExtension';

        await supabase.storage.from('images').upload(fileName, file);
        finalAvatarUrl = supabase.storage.from('images').getPublicUrl(fileName);
      }

      await supabase
          .from('profiles')
          .update({
        'full_name': nameController.text.trim(),
        'avatar_url': finalAvatarUrl,
      })
          .eq('id', user.id);

      if (Get.isRegistered<SettingsController>()) {
        final settingsCtrl = Get.find<SettingsController>();
        await settingsCtrl.loadUserData();
      }

      AuthHelper.hideLoading();
      Get.back();
      AppAlerts.success(message: AppMessages.updateSuccess);

    } catch (e) {
      AuthHelper.hideLoading();
      AppAlerts.error(message: e.toString());
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    super.onClose();
  }
}