import 'package:get/get.dart';
import '../controllers/attendance_controller.dart';

class TaskHomeBiding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut(() => TaskHomeController(),);
  }
}