import 'package:clockly/features/auth/controllers/auth_base_controller.dart';
import 'package:email_validator/email_validator.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/components/custom_snackbar.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/theme/app_colors.dart';
import 'auth_helper.dart';

class ForgotPasswordController extends GetxController{
  final authService = Get.find <AuthService>();

  final otpErrorText = RxnString(null);
  final pinController = PinInputController();
  String tempEmail = "";
  AuthBaseController? controller;

  Future<void> sendPasswordReset() async {
    final email = controller!.emailController.text.trim();

    if (email.isEmpty || !EmailValidator.validate(email)) {
      CustomSnackbar.snackbar("Error", "Please enter a valid email", AppColors.red);
      return;
    }

    try {
      AuthHelper.showLoading();

      //  TEST test submit OTP
      // await authService.sendPasswordReset (email);
      await Future.delayed(const Duration(seconds: 2));
      tempEmail = email;

      AuthHelper.hideLoading();

      CustomSnackbar.snackbar("Success", "OTP has been sent to your email", AppColors.green);
      AuthHelper.dialogOTP(OtpType.recovery);

    } on AuthException catch (e) {
      AuthHelper.hideLoading();
      CustomSnackbar.snackbar("Error", e.message, AppColors.red);
    } catch (e) {
      AuthHelper.hideLoading();
      CustomSnackbar.snackbar("Error", "An unexpected error occurred", AppColors.red);
    }
  }

  @override
  void onInit() {
    super.onInit();
    if (!Get.isRegistered<AuthBaseController>()) {
      controller = Get.put(AuthBaseController());
    }
    else {
      controller = Get.find<AuthBaseController>();
    }
  }
}