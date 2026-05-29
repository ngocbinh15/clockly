import 'package:clockly/features/setting/controller/notification_controller.dart';
import 'package:get/get.dart';
import '../../analys/controller/analysis_controller.dart';
import '../../calendar/controller/calendar_controller.dart';
import '../controllers/task_home_controller.dart';
import '../../leader_board/controller/team_controller.dart';

class MainHomeBiding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TaskHomeController());
    Get.lazyPut(() => TeamController());
    Get.lazyPut(() => AnalysisController());
    Get.lazyPut(() => CalendarController());
    Get.put(NotificationController());
  }
}
