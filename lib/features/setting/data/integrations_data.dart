import 'package:clockly/core/theme/app_colors.dart';
import 'package:clockly/features/setting/model/integration_model.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class IntegrationsData {
  static List<IntegrationModel> items = [
    IntegrationModel(
      id: "google_cal",
      name: "Google Calendar",
      desc: "Sync your tasks with Google events",
      icon: HugeIcons.strokeRoundedGoogle,
      color: Colors.redAccent,
      isConnected: true,
    ),
    IntegrationModel(
      id: "slack",
      name: "Slack",
      desc: "Get task reminders in your channels",
      icon: HugeIcons.strokeRoundedSlack,
      color: Colors.deepPurpleAccent,
      isConnected: false,
    ),
    IntegrationModel(
      id: "notion",
      name: "Notion",
      desc: "Export your completed tasks to Notion",
      icon: HugeIcons.strokeRoundedAiBrain01,
      color: AppColors.grey,
      isConnected: false,
    ),
    IntegrationModel(
      id: "outlook",
      name: "Outlook",
      desc: "Sync with Microsoft 365 services",
      icon: HugeIcons.strokeRoundedMail02,
      color: Colors.blueAccent,
      isConnected: false,
    ),
  ];
}
