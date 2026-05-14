import 'package:clockly/features/auth/controllers/sign_up_controller.dart';
import 'package:get/get.dart';

class SignUpBidings extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut(() => SignUpController(),);
  }
}