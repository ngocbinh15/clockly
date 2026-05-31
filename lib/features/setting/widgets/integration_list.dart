import 'package:clockly/features/setting/model/integration_model.dart';
import 'package:clockly/features/setting/widgets/integration_tile.dart';
import 'package:flutter/material.dart';

class IntegrationList extends StatelessWidget {
  const IntegrationList({super.key, required this.items, required this.isDark});

  final List<IntegrationModel> items;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items
          .map((item) => IntegrationTile(item: item, isDark: isDark))
          .toList(),
    );
  }
}
