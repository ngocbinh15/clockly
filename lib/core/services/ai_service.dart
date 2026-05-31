import 'dart:convert';
import 'package:clockly/core/components/app_alerts.dart';
import 'package:clockly/core/services/auth_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AiService extends GetxService {
  final authService = Get.find<AuthService>();

  final _groqApiKey = dotenv.env['GROQ_API_KEY'] ?? "";


  Future<Map<String, dynamic>?> parseTaskFromText(String prompt) async {
    if (_groqApiKey.trim().isEmpty) {
      AppAlerts.error(message: "API Key is missing");
      return null;
    }

    final today = DateTime.now();

    try {
      final response = await http.post(
        Uri.parse('https://api.groq.com/openai/v1/chat/completions'),
        headers: {
          'Authorization': 'Bearer $_groqApiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "model": "llama-3.3-70b-versatile",
          "messages": [
            {
              "role": "system",
              "content": '''
                  You are a task parsing system.
                  Read the user's input and return ONLY a standard JSON object,
                  without markdown, without explanation, and without any additional text outside the JSON.
                  
                  Required JSON structure:
                  {
                    "title": String,
                    "description": String,
                    "due_date": "MMM dd, yyyy - hh:mm a",
                    "category": "General | Study | Coding | Teaching | Work | Health | Personal",
                    "priority": "Low | Medium | High"
                  }
                  
                  Today is $today.
                  
                  Time rules:
                  - "ngày mai" (tomorrow) = +1 day
                  - "ngày mốt" (day after tomorrow) = +2 days
                  - "ngày kia" (3 days from now) = +3 days
                  
                  Rules:
                  - "title" must be short and concise
                  - "description" should describe details if information is present
                  - If the user does not input a specific time, default to "12:00"
                  - If the category cannot be determined, use "General"
                  - If the priority cannot be determined, use "Medium"
                  
                  Priority rules:
                  - Words like "gấp", "quan trọng", "urgent", "ASAP" => "High"
                  - Words like "khi rảnh", "không gấp" => "Low"
                  
                  Example Input:
                  "mai 8h học DSA chapter graph để chuẩn bị phỏng vấn"
                  
                  Example Output:
                  {
                    "title": "Học DSA",
                    "description": "Học chapter graph để chuẩn bị phỏng vấn",
                    "due_date": "2026-05-22 08:00:00",
                    "category": "Study",
                    "priority": "Medium"
                  }
                  ''',
            },
            {
              "role": "user",
              "content": prompt
            }
          ],
          "response_format": {"type": "json_object"},
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        final jsonString = data['choices'][0]['message']['content'];

        return jsonDecode(jsonString) as Map<String, dynamic>;
      } else {
        AppAlerts.error(message: "Something went wrong on the server: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      AppAlerts.error(message: "Unable to connect: $e");
      return null;
    }
  }
}