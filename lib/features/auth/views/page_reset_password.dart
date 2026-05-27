import 'package:clockly/features/auth/controllers/forgot_password_controller.dart';
import 'package:clockly/features/auth/widgets/form_reset_password.dart';
import 'package:clockly/features/auth/widgets/heading_auth.dart';
import 'package:clockly/features/auth/widgets/main_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

class PageResetPassword extends GetView<ForgotPasswordController> {
  const PageResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return MainTheme(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          HeadingAuth(
            icon: HugeIcons.strokeRoundedResetPassword,
            heading: "Reset Password",
            title: "Please enter the new password to your account",
          ),

          FormResetPassword(),
        ],
      ),
    );
  }
}
