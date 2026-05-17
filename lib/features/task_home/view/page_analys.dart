import 'package:clockly/core/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/custom_bottom_nav.dart';

class PageAnalys extends StatelessWidget {
  const PageAnalys({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page analys"),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () => Get.find<AuthService>().logout(),
              child: Text("Sign out")
          )
        ],
      ),
    );
  }
}
