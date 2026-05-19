import 'package:get/get.dart';

import '../controller/analys_controller.dart';

class AnalysBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AnalysController>(() => AnalysController());
  }
}