import 'package:clockly/core/services/ai_service.dart';
import 'package:clockly/core/services/app_info_service.dart';
import 'package:clockly/core/services/auth_service.dart';
import 'package:clockly/core/services/notification_service.dart';
import 'package:clockly/features/setting/controller/notification_controller.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthService());
    Get.put(NotificationService());
    Get.put(AiService());

    Get.put(NotificationController());
    Get.putAsync<AppInfoService>(() => AppInfoService().init());
  }
}
