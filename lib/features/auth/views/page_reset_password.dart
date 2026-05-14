import 'package:clockly/core/components/text_title.dart';
import 'package:clockly/features/auth/controllers/forgot_password_controller.dart';
import 'package:clockly/features/auth/splash/widget/main_logo.dart';
import 'package:clockly/features/auth/widgets/form_reset_password.dart';
import 'package:clockly/features/auth/widgets/heading_auth.dart';
import 'package:clockly/features/auth/widgets/main_icon.dart';
import 'package:clockly/features/auth/widgets/main_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../core/components/text_heading.dart';
import '../../../core/constants/app_size.dart';

class PageResetPassword extends GetView <ForgotPasswordController> {
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
                title: "Please enter the new password to your account"
            ),

            FormResetPassword()
          ],
        ),
    );
  }
}
