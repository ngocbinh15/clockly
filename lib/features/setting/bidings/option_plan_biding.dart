import 'package:clockly/features/setting/controller/option_plan_controller.dart';
import 'package:get/get.dart';

class OptionPlanBiding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => OptionPlanController(),);
  }
  
}