import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/components/custom_snackbar.dart';
import '../../../core/theme/app_colors.dart';
import '../../../routes/app_routes.dart';
import 'auth_helper.dart';

class OtpController extends GetxController{
  final otpErrorText = RxnString(null);
  final pinController = PinInputController();
  final supabase = Supabase.instance.client;

  Future<void> confirmOTP(String otp, OtpType type) async {
    try {
      AuthHelper.showLoading();

      // TEST submit OTP
      // await authService.verifyOTP(
      //   tempEmail.isNotEmpty ? tempEmail : emailController.text.trim(),
      //   otp,
      //   type,
      // );

      await Future.delayed(const Duration(seconds: 2));
      AuthHelper.hideLoading();

      if (Get.isDialogOpen ?? false) {
        Get.back();
      }

      _handleSuccess(type);

    } on AuthException catch (e) {
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
        await supabase.auth.signOut();
        CustomSnackbar.snackbar("Welcome!", "Your account is ready. You can now log in.", AppColors.green);
        Get.offAllNamed(AppRoutes.login);
        break;

      case OtpType.recovery:
        Get.toNamed(AppRoutes.resetPassword);
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