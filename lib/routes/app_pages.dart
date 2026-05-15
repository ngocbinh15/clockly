import 'package:clockly/features/auth/bidings/forgot_password_bidings.dart';
import 'package:clockly/features/auth/bidings/login_bidings.dart';
import 'package:clockly/features/auth/bidings/sign_up_bidings.dart';
import 'package:clockly/features/auth/bidings/splash_bidings.dart';
import 'package:clockly/features/auth/splash/splash_page.dart';
import 'package:clockly/features/auth/views/page_forgot_password.dart';
import 'package:clockly/features/auth/views/page_login.dart';
import 'package:clockly/features/auth/views/page_reset_password.dart';
import 'package:clockly/features/auth/views/page_sign_up.dart';
import 'package:clockly/features/task_home/view/page_main_home.dart';
import 'package:clockly/routes/app_routes.dart';
import 'package:get/get.dart';

import '../features/task_home/bidings/main_home_biding.dart';

class AppPages {
  static final routes = [
    GetPage(
        name: AppRoutes.login,
        page: () => PageLogin(),
      binding: LoginBidings()
    ),
    GetPage(
        name: AppRoutes.home,
        page: () => PageMainHome(),
      binding: MainHomeBiding()
    ),
    GetPage(
        name: AppRoutes.splash,
        page: () => PageSplash(),
      binding: SplashBidings()
    ),
    GetPage(
        name: AppRoutes.forgotPassword,
        page: () => PageForgotpassword(),
      binding: ForgotPasswordBidings()
    ),

    GetPage(
        name: AppRoutes.resetPassword,
        page: () => PageResetPassword(),
    ),
    GetPage(
        name: AppRoutes.signUp,
        page: () => PageSignUp(),
      binding: SignUpBidings()
    ),
  ];
}