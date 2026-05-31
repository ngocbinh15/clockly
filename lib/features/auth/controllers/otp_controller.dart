import 'package:clockly/core/components/app_alerts.dart';
import 'package:clockly/core/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../routes/app_routes.dart';
import 'auth_helper.dart';

class OtpController extends GetxController {
  final otpErrorText = RxnString(null);
  final pinController = PinInputController();
  final supabase = Supabase.instance.client;
  final authService = Get.find<AuthService>();

  Future<void> confirmOTP(String otp, OtpType type, String email) async {
    try {
      AuthHelper.showLoading();

      // TEST submit OTP
      await authService.verifyOTP(email.trim(), otp, type);
      //
      // await Future.delayed(const Duration(seconds: 2));
      AuthHelper.hideLoading();

      if (Get.isDialogOpen ?? false) {
        Get.back();
      }

      _handleSuccess(type);
    } on AuthException catch (_) {
      AuthHelper.hideLoading();
      _handleOtpError("Invalid or expired code.");
    } catch (e) {
      AuthHelper.hideLoading();
      _handleOtpError("Invalid or expired code.");
    }
  }

  void _handleOtpError(String message) {
    otpErrorText.value = message;
    pinController.triggerError();

    Future.delayed(const Duration(milliseconds: 1200), () {
      pinController.clear();
      otpErrorText.value = null;
    });
  }

  void _handleSuccess(OtpType type) async {
    switch (type) {
      case OtpType.signup:
        await Get.find<AuthService>().logout();
        AppAlerts.success(
          title: "Welcome!",
          message: "Your account is ready. You can now log in.",
        );
        break;

      case OtpType.recovery:
        Get.toNamed(AppRoutes.resetPassword);
        pinController.clear();
        break;

      default:
        break;
    }
  }

  @override
  void onClose() {
    super.onClose();
    pinController.dispose();
  }
}
