import 'package:clockly/core/constants/app_size.dart';
import 'package:clockly/core/utils/theme_helper.dart';
import 'package:clockly/features/setting/data/integrations_data.dart';
import 'package:clockly/features/setting/widgets/heading_setting.dart';
import 'package:clockly/features/setting/widgets/integration_footer.dart';
import 'package:clockly/features/setting/widgets/integration_intro.dart';
import 'package:clockly/features/setting/widgets/integration_list.dart';
import 'package:flutter/material.dart';

class PageIntegrations extends StatelessWidget {
  const PageIntegrations({super.key});

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
              const HeadingSetting(text: "Integrations"),

              const SizedBox(height: AppSizes.p20),

              const IntegrationIntro(),

              const SizedBox(height: AppSizes.p24),

              IntegrationList(
                items: IntegrationsData.items,
                isDark: ThemeHelper.isDark,
              ),

              const SizedBox(height: AppSizes.p32),

              const IntegrationFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
