import 'package:clockly/features/auth/controllers/sign_up_controller.dart';
import 'package:clockly/features/auth/widgets/form_sign_up.dart';
import 'package:clockly/features/auth/widgets/heading_auth.dart';
import 'package:clockly/features/auth/widgets/main_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

class PageSignUp extends GetView<SignUpController> {
  const PageSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return MainTheme(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          HeadingAuth(
            icon: HugeIcons.strokeRoundedAssignments,
            heading: "Create Account",
            title: "Join to boost your daily productivity",
          ),

          FormSignUp(),
        ],
      ),
    );
  }
}
