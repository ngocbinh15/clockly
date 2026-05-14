import 'package:flutter/cupertino.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../core/components/text_heading.dart';
import '../../../core/components/text_title.dart';
import '../../../core/constants/app_size.dart';
import 'main_icon.dart';

class HeadingAuth extends StatelessWidget {
  HeadingAuth({super.key, required this.icon, required this.heading, required this.title});

  String heading, title;
  final icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MainIcon(icon: icon),
        SizedBox(height: AppSizes.p24),

        TextHeading(textHeading: heading),
        SizedBox(height: AppSizes.p8),

        TextTitle(titleText: title),
        SizedBox(height: AppSizes.p32),
      ],
    );
  }
}
