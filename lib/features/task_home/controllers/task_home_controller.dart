import 'package:clockly/core/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TaskHomeController extends GetxController{
  final String today = DateFormat('MMM dd, yyyy').format(DateTime.now());
  final currUser = Get.find<AuthService>().currentUser.value;

  String getGreetingText() {
    final hour = DateTime.now().hour;

    if (hour >= 18) return "Good Evening";
    if (hour >= 12) return "Good Afternoon";
    return "Good Morning";
  }
}