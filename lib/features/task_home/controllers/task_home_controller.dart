import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TaskHomeController extends GetxController{
  final String today = DateFormat('MMM dd, yyyy').format(DateTime.now());
}