import 'package:get/get.dart';
import '../controllers/task_home_controller.dart';

class TaskHomeBiding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut(() => TaskHomeController(),);
  }
}