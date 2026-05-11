import 'package:clockly/features/attendance/bidings/attendance_biding.dart';
import 'package:clockly/features/attendance/view/page_attendance.dart';
import 'package:clockly/features/auth/bidings/login_bidings.dart';
import 'package:clockly/features/auth/splash/splash_page.dart';
import 'package:clockly/features/auth/views/page_forgot_password.dart';
import 'package:clockly/features/auth/views/page_login.dart';
import 'package:clockly/routes/app_routes.dart';
import 'package:get/get.dart';

class AppPages {
  static final routes = [
    GetPage(
        name: AppRoutes.login,
        page: () => PageLogin(),
      binding: LoginBidings()
    ),
    GetPage(
        name: AppRoutes.home,
        page: () => PageAttendance(),
      binding: AttendanceBiding()
    ),
    GetPage(
        name: AppRoutes.splash,
        page: () => PageSplash(),
    ),
    GetPage(
        name: AppRoutes.resetPassword,
        page: () => PageForgotpassword(),
    )
  ];
}