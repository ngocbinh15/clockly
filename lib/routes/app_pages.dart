import 'package:clockly/features/auth/bidings/login_bidings.dart';
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
  ];
}