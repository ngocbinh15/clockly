import 'package:clockly/features/auth/controllers/login_controller.dart';
import 'package:get/get.dart';

class LoginBidings extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut(() => LoginController(),);
  }
}