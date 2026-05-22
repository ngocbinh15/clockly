import 'package:clockly/features/task_home/controllers/task_home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'chat_empty_state.dart';
import 'chat_messages_view.dart';

class MainChatBody extends GetView<TaskHomeController> {
  const MainChatBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isSend.value) {
        return const ChatMessagesView();
      } else {
        return const ChatEmptyState();
      }
    });
  }
}