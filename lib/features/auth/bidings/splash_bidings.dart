import 'package:clockly/features/auth/controllers/splash_controller.dart';
import 'package:get/get.dart';

class SplashBidings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController(),);
  }
}