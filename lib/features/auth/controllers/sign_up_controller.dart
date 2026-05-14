import 'package:clockly/core/components/custom_snackbar.dart';
import 'package:clockly/core/services/auth_service.dart';
import 'package:clockly/core/theme/app_colors.dart';
import 'package:clockly/features/auth/controllers/auth_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpController extends GetxController{
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  final authService = Get.find<AuthService>();

  Future<void> onRegisterPressed() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final name = nameController.text.trim();

    try {
      AuthHelper.showLoading();

      await authService.signUp(email, password, name);

      AuthHelper.hideLoading();

      AuthHelper.dialogOTP(OtpType.signup, email);


      nameController.clear();
      emailController.clear();
      confirmController.clear();
      passwordController.clear();
    } catch (e) {
      AuthHelper.hideLoading();
      CustomSnackbar.snackbar('Error', e.toString(), AppColors.red);
    }
  }
}