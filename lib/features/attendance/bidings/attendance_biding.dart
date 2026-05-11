import 'package:clockly/features/attendance/controllers/attendance_controller.dart';
import 'package:get/get.dart';

class AttendanceBiding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut(() => AttendanceController(),);
  }
}