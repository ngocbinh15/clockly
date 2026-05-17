import 'package:clockly/core/services/auth_service.dart';
import 'package:get/get.dart';

class SplashController extends GetxController{
  final authService = Get.find<AuthService>();

  @override
  void onReady() async {
    super.onReady();
    await Future.delayed(const Duration(seconds: 2));
    authService.setupAuthListener();
  }
}