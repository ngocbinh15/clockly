import 'package:clockly/features/auth/controllers/forgot_password_controller.dart';
import 'package:get/get.dart';

class ForgotPasswordBidings extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut(() => ForgotPasswordController(),);
  }
}