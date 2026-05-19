import 'package:clockly/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class TextHeading extends StatelessWidget {
  TextHeading({super.key, required this.textHeading});
  String textHeading;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextHeading(textHeading: "Setting"),
      ],
    );
  }
}
