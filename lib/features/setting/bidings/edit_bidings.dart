import 'package:clockly/features/setting/controller/edit_profile_controller.dart';
import 'package:get/get.dart';

class EditBidings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditProfileController());
  }
}
