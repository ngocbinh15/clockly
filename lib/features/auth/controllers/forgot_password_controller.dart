import 'package:clockly/core/components/app_alerts.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/services/auth_service.dart';
import 'auth_helper.dart';

class ForgotPasswordController extends GetxController {
  final authService = Get.find<AuthService>();

  final otpErrorText = RxnString(null);
  late PinInputController pinController;
  String tempEmail = "";
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    pinController = PinInputController();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    pinController.dispose();
    super.onClose();
  }

  Future<void> sendPasswordReset() async {
    final email = emailController.text.trim();

    try {
      AuthHelper.showLoading();

      //  TEST test submit OTP
      await authService.sendPasswordReset(email);
      // await Future.delayed(const Duration(seconds: 2));
      tempEmail = email;

      AuthHelper.hideLoading();

      AppAlerts.success(message: "OTP has been sent to your email");
      AuthHelper.dialogOTP(OtpType.recovery, email);
    } on AuthException catch (e) {
      AuthHelper.hideLoading();
      AppAlerts.error(message: "$e");
    } catch (e) {
      AuthHelper.hideLoading();
      AppAlerts.error(message: "$e");
    }
  }

  Future<void> resetPassword() async {
    try {
      await authService.resetPassword(passwordController.text.trim());
      authService.logout();
      AppAlerts.success(
        title: "Welcome!",
        message: "Your account is ready.",
      );
    } catch (e) {
      AppAlerts.error(message: "$e");
    }
  }
}
