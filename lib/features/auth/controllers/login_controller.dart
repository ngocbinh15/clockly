import 'package:clockly/core/components/app_alerts.dart';
import 'package:clockly/core/constants/app_message.dart';
import 'package:clockly/core/services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'auth_helper.dart';

class LoginController extends GetxController {
  final supabase = Supabase.instance.client;
  final authService = Get.find<AuthService>();

  var obscurePassword = true.obs;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String tempEmail = "";

  Future<void> signIn() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    try {
      AuthHelper.showLoading();

      await authService.signIn(email, password);

      AuthHelper.hideLoading();

      emailController.clear();
      passwordController.clear();

    } on AuthException catch (e) {
      AuthHelper.hideLoading();
      AppAlerts.error(message: AppMessages.defaultError);
    } catch (e) {
      AuthHelper.hideLoading();
      AppAlerts.error(message: "$e");
    }
  }

  void toggleObscurePassword() {
    obscurePassword.value = !obscurePassword.value;
  }
}