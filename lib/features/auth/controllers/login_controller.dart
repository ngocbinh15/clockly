import 'package:clockly/features/auth/controllers/auth_base_controller.dart';
import 'package:clockly/core/services/auth_service.dart';
import 'package:clockly/core/theme/app_colors.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/components/custom_snackbar.dart';
import 'auth_helper.dart';

class LoginController extends GetxController {
  final supabase = Supabase.instance.client;
  final authService = Get.find <AuthService>();

  var obscurePassword = true.obs;

  AuthBaseController? controller;

  String tempEmail = "";

  Future<void> signIn() async {
    final email = controller!.emailController.text.trim();
    final password = controller!.passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      CustomSnackbar.snackbar("Error", "Please fill in all fields", AppColors.red);
      return;
    }

    try {
      AuthHelper.showLoading();
      await authService.signIn(email, password);
    } on AuthException catch (e) {
      AuthHelper.hideLoading();
      CustomSnackbar.snackbar("Login Failed", e.message, AppColors.red);
    } catch (e) {
      AuthHelper.hideLoading();
      CustomSnackbar.snackbar("Error", "An unexpected error occurred", AppColors.red);
    }
  }

  void toggleObscurePassword() {
    obscurePassword.value = !obscurePassword.value;
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

  @override
  void onClose() {
    super.dispose();
    controller!.dispose();
  }
}