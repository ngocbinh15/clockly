import 'package:clockly/core/components/custom_text_button.dart';
import 'package:clockly/core/components/primary_button.dart';
import 'package:clockly/core/constants/app_size.dart';
import 'package:clockly/core/theme/app_colors.dart';
import 'package:clockly/core/utils/theme_helper.dart';
import 'package:clockly/features/setting/controller/settings_controller.dart';
import 'package:clockly/features/setting/widgets/heading_setting.dart';
import 'package:clockly/features/setting/widgets/privacy_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

class PagePrivacyTerms extends GetView<SettingsController> {
  PagePrivacyTerms({super.key});

  final List<Map<String, dynamic>> privacyterms = [
    {
      "icon": HugeIcons.strokeRoundedDatabase,
      "title": "Data Collection",
      "subtitle":
          "Clockly collects minimal personal information required to manage your productivity. This includes your profile details (email, name) and the task metadata you create. All task content is encrypted at rest.",
    },
    {
      "icon": HugeIcons.strokeRoundedMagicWand04,
      "title": "AI Data Processing",
      "subtitle":
          "Clockly AI processes task prompts to generate smart scheduling suggestions. We do not use your private task data to train global AI models. Your prompts are anonymized before being sent to our processing partners.",
    },
    {
      "icon": HugeIcons.strokeRoundedKnightShield,
      "title": "Data Security",
      "subtitle":
          "We employ industry-standard TLS encryption for all data in transit. Our servers are hosted in secure, SOC2-compliant data centers with 24/7 monitoring and automated threat detection.",
    },
    {
      "icon": HugeIcons.strokeRoundedPowerService,
      "title": "Third-party Services",
      "subtitle":
          "We integrate with Calendar providers (Google, Outlook) only with your explicit permission. We never sell your personal data to advertisers or third-party data brokers.",
    },
    {
      "icon": HugeIcons.strokeRoundedFileTerminal,
      "title": "Acceptance of Terms",
      "subtitle":
          "By accessing or using Clockly, you agree to be bound by these Terms. If you disagree with any part of the terms, you may not access the service.",
    },

    {
      "icon": HugeIcons.strokeRoundedUserCircle,
      "title": "User Accounts",
      "subtitle":
          "When you create an account, you must provide accurate information. You are responsible for safeguarding your password and for all activities under your account.",
    },

    {
      "icon": HugeIcons.strokeRoundedAiBrain01,
      "title": "AI Assistant Usage",
      "subtitle":
          "Our AI tools are designed to assist with scheduling. You agree not to use the AI to generate harmful, illegal, or deceptive content. AI suggestions should be reviewed before finalizing critical tasks.",
    },
    {
      "icon": HugeIcons.strokeRoundedBubbleChatBlocked,
      "title": "Prohibited Activities",
      "subtitle":
          "You may not attempt to circumvent our security, scrape data, or use the service to disrupt other users. Violation may result in immediate account termination.",
    },
    {
      "icon": HugeIcons.strokeRoundedLegalHammer,
      "title": "Limitation of Liability",
      "subtitle":
          "Clockly is provided \"as is\". We shall not be liable for any indirect, incidental, or consequential damages arising out of your use of the service.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final colorSubText = AppColors.grey;

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

              Text(
                "We value your trust above all. This page outlines how we handle your data and the rules for using our platform.",
                style: GoogleFonts.inter(
                  color: colorSubText,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: AppSizes.p16),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const HugeIcon(
                      icon: HugeIcons.strokeRoundedClock05,
                      color: AppColors.primary,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Last updated: May 31, 2026",
                      style: GoogleFonts.inter(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSizes.p24),

              Column(
                children: privacyterms.map((item) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: AppSizes.p16),
                    child: PrivacySection(
                      title: item["title"],
                      content: item["subtitle"],
                      icon: item["icon"],
                    ),
                  );
                }).toList(),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(thickness: 1.2),
              ),

              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Have question or need clarification?",
                      style: GoogleFonts.inter(
                        color: ThemeHelper.isDark
                            ? Colors.white
                            : Colors.black87,
                      ),
                    ),

                    SizedBox(height: AppSizes.p4),

                    CustomTextButton(
                      color: AppColors.primary,
                      text: "binhnguyenngoc.it@gmail.com",
                      onTap: () => controller.launchSupportEmail(),
                    ),

                    SizedBox(height: 16),

                    PrimaryButton(
                      text: "Back to Settings",
                      onPressed: () => Get.back(),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
