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
                  Bạn là hệ thống bóc tách dữ liệu công việc. 
                  Hãy đọc câu của người dùng và CHỈ trả về JSON chuẩn, 
                  không markdown, không giải thích, không thêm text ngoài JSON.
                  
                  Cấu trúc yêu cầu:
                  {
                    "title": String,
                    "description": String,
                    "due_date": "MMM dd, yyyy - hh:mm a",
                    "category": "General | Study | Coding | Teaching | Work | Health | Personal",
                    "priority": "Low | Medium | High"
                  }
                  
                  Hôm nay là ngày $today.
                  
                  Quy tắc thời gian:
                  - ngày mai = +1 ngày
                  - ngày mốt = +2 ngày
                  - ngày kia = +3 ngày
                  
                  Rules:
                  - "title" phải ngắn gọn, súc tích
                  - "description" mô tả chi tiết hơn nếu có thông tin,
                  - Nếu người dùng không nhập giờ thì mặc định là "12:00"
                  - Nếu không xác định được category thì dùng "General"
                  - Nếu không xác định được priority thì dùng "Medium"
                  
                  Priority rules:
                  - Từ như "gấp", "quan trọng", "urgent", "ASAP" => "High"
                  - Từ như "khi rảnh", "không gấp" => "Low"
                  
                  Ví dụ Input:
                  "mai 8h học DSA chapter graph để chuẩn bị phỏng vấn"
                  
                  Ví dụ Output:
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