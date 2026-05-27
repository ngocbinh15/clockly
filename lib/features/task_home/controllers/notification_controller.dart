import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _requestPermissionNotification();
  }

  void _requestPermissionNotification() async {
    var status = await Permission.notification.status;

    if (status.isDenied) {
      status =  await Permission.notification.request();
    }

    if (status.isPermanentlyDenied) {
      await openAppSettings();
    }
  }
}
