import 'package:clockly/features/setting/controller/EditProfileController.dart';
import 'package:get/get.dart';

class EditBidings extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut(() => EditProfileController(),);
  }
}