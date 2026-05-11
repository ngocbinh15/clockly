import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app.dart';
import 'core/services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://ymkcbkaovbltevxozawe.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inlta2Nia2FvdmJsdGV2eG96YXdlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzgyMzEzOTMsImV4cCI6MjA5MzgwNzM5M30.DCWuPfgdD0Ql-HUzKa1SNnCKWVvDrR3rpun1H1Aenc0',
  );

  Get.put(AuthService());
  runApp(const MyApp());
}