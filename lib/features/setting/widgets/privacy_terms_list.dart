import 'package:clockly/core/constants/app_size.dart';
import 'package:clockly/features/setting/widgets/privacy_section.dart';
import 'package:flutter/material.dart';

class PrivacyTermsList extends StatelessWidget {
  const PrivacyTermsList({super.key, required this.items});

  final List<Map<String, dynamic>> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items.map((item) {
        return Padding(
          padding: const EdgeInsets.only(bottom: AppSizes.p16),
          child: PrivacySection(
            title: item["title"],
            content: item["subtitle"],
            icon: item["icon"],
          ),
        );
      }).toList(),
    );
  }
}
