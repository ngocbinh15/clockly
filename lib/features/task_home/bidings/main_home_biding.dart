import 'package:get/get.dart';
import '../controllers/analys_controller.dart';
import '../controllers/calendar_controller.dart';
import '../controllers/task_home_controller.dart';
import '../controllers/team_controller.dart';

class MainHomeBiding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => TaskHomeController(),);
    Get.lazyPut(() => TeamController(),);
    Get.lazyPut(() => AnalysController(),);
    Get.lazyPut(() => CalendarController(),);
  }
}