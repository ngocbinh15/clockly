import 'package:clockly/core/constants/app_size.dart';
import 'package:clockly/features/setting/controller/settings_controller.dart';
import 'package:clockly/features/setting/data/privacy_terms_data.dart';
import 'package:clockly/features/setting/widgets/heading_setting.dart';
import 'package:clockly/features/setting/widgets/privacy_footer.dart';
import 'package:clockly/features/setting/widgets/privacy_header.dart';
import 'package:clockly/features/setting/widgets/privacy_terms_list.dart';
import 'package:clockly/features/setting/widgets/privacy_update_badge.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PagePrivacyTerms extends GetView<SettingsController> {
  const PagePrivacyTerms({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.p24,
            vertical: AppSizes.p16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeadingSetting(text: "Privacy & Terms"),
              const SizedBox(height: AppSizes.p20),

              const PrivacyHeader(),

              const SizedBox(height: AppSizes.p16),

              const PrivacyUpdateBadge(),

              const SizedBox(height: AppSizes.p24),

              PrivacyTermsList(items: PrivacyTermsData.items),

              const Padding(
                padding: EdgeInsets.all(8),
                child: Divider(thickness: 1.2),
              ),

              const PrivacyFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
