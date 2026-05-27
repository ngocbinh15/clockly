import 'package:clockly/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class TextHeading extends StatelessWidget {
  const TextHeading({super.key, required this.textHeading});
  final String textHeading;

  @override
  Widget build(BuildContext context) {
    return Text(textHeading, style: AppTextStyles.heading);
  }
}
