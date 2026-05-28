import 'package:clockly/features/setting/controller/option_plan_controller.dart';
import 'package:get/get.dart';
import '../controller/settings_controller.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingsController());
    Get.lazyPut(() => OptionPlanController());
  }
}
