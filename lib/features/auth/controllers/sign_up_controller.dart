import 'package:clockly/core/components/custom_snackbar.dart';
import 'package:clockly/core/services/auth_service.dart';
import 'package:clockly/core/theme/app_colors.dart';
import 'package:clockly/features/auth/controllers/auth_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/components/app_alerts.dart';

class SignUpController extends GetxController {
  final authService = Get.find<AuthService>();

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmController;

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmController = TextEditingController();
  }

  Future<void> onRegisterPressed() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final name = nameController.text.trim();

    try {
      AuthHelper.showLoading();
      await authService.signUp(email, password, name);
      AuthHelper.hideLoading();

      AuthHelper.dialogOTP(OtpType.signup, email);

      _resetFields();
    } catch (e) {
      AuthHelper.hideLoading();
      AppAlerts.error(message: "$e");
    }
  }

  void _resetFields() {
    nameController.clear();
    emailController.clear();
    confirmController.clear();
    passwordController.clear();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.onClose();
  }
}