import 'package:clockly/features/auth/controllers/auth_base_controller.dart';
import 'package:get/get.dart';

class AuthBaseBidings extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut(() => AuthBaseController(),);
  }
}