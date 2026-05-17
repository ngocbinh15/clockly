import 'package:get/get.dart';
import '../../setting/controllers/settings_controller.dart';
import '../controllers/attendance_controller.dart';

class TaskHomeBiding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => TaskHomeController());
    Get.lazyPut(() => SettingsController());
  }
}