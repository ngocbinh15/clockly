import 'package:get/get.dart';
import '../../analys/controller/analys_controller.dart';
import '../../calendar/controller/calendar_controller.dart';
import '../controllers/task_home_controller.dart';
import '../../leader_board/controller/team_controller.dart';

class MainHomeBiding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => TaskHomeController(),);
    Get.lazyPut(() => TeamController(),);
    Get.lazyPut(() => AnalysController(),);
    Get.lazyPut(() => CalendarController(),);
  }
}