import 'package:clockly/core/theme/app_colors.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/components/custom_snackbar.dart';
import '../../../routes/app_routes.dart';
import 'auth_helper.dart';

class LoginController extends GetxController {
  final supabase = Supabase.instance.client;

  var obscurePassword = true.obs;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String tempEmail = "";

  Future<void> signIn() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      CustomSnackbar.snackbar("Error", "Please fill in all fields", AppColors.red);
      return;
    }

    try {
      AuthHelper.showLoading();
      await supabase.auth.signInWithPassword(password: password, email: email);
    } on AuthException catch (e) {
      AuthHelper.hideLoading();
      CustomSnackbar.snackbar("Login Failed", e.message, AppColors.red);
    } catch (e) {
      AuthHelper.hideLoading();
      CustomSnackbar.snackbar("Error", "An unexpected error occurred", AppColors.red);
    }
  }

  Future<void> sendPasswordReset() async {
    final email = emailController.text.trim();

    if (email.isEmpty || !EmailValidator.validate(email)) {
      CustomSnackbar.snackbar("Error", "Please enter a valid email", AppColors.red);
      return;
    }

    try {
      AuthHelper.showLoading();

      await supabase.auth.resetPasswordForEmail(email);
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

  Future<void> confirmOTP(String otp, OtpType type) async {
    try {
      AuthHelper.showLoading();

      await supabase.auth.verifyOTP(
        type: type,
        token: otp,
        email: tempEmail.isNotEmpty ? tempEmail : emailController.text.trim(),
      );

      AuthHelper.hideLoading();

      if (Get.isDialogOpen ?? false) Get.back();

      _handleSuccess(type);

    } on AuthException catch (e) {
      AuthHelper.hideLoading();
      CustomSnackbar.snackbar("Xác thực thất bại", e.message, AppColors.red);
    } catch (e) {
      AuthHelper.hideLoading();
      CustomSnackbar.snackbar("Lỗi", "Mã OTP không chính xác hoặc đã hết hạn", AppColors.red);
    }
  }

  void _handleSuccess(OtpType type) async {
    switch (type) {
      case OtpType.signup:
        await supabase.auth.signOut();
        CustomSnackbar.snackbar("Thành công", "Đăng ký thành công, mời bạn đăng nhập", AppColors.green);
        Get.offAllNamed(AppRoutes.login);
        break;

      case OtpType.recovery:
        Get.toNamed(AppRoutes.resetPassword);
        break;

      default:
        break;
    }
  }

  void toggleObscurePassword() {
    obscurePassword.value = !obscurePassword.value;
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}