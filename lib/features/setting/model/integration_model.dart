import 'package:flutter/material.dart';

class IntegrationModel {
  final String id;
  final String name;
  final String desc;
  final dynamic icon;
  final Color color;
  final bool isConnected;

  const IntegrationModel({
    required this.id,
    required this.name,
    required this.desc,
    required this.icon,
    required this.color,
    required this.isConnected,
  });
}
