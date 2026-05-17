import 'package:clockly/core/services/app_info_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AppInfo extends StatelessWidget {
  AppInfo({super.key});

  final appInfoService = Get.find <AppInfoService> ();

  @override
  Widget build(BuildContext context) {
    return  Text(
      "${appInfoService.appName} ${appInfoService.version}",
      style: GoogleFonts.inter(
        color: const Color(0xFF64748B),
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
