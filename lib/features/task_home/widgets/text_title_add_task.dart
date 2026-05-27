import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../../core/utils/theme_helper.dart';

class TextTitleAddTask extends StatelessWidget {
	TextTitleAddTask({super.key, required this.text});

	final String text;

	@override
	Widget build(BuildContext context) {
		return Obx(() {
			final isDark = ThemeHelper.isDark;
			return Text(
				text,
				style: GoogleFonts.inter(
					fontSize: 16,
					fontWeight: FontWeight.w600,
					color: isDark ? Colors.white : Colors.black,
				),
			);
		});
	}
}
