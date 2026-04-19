import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/ai_model.dart';

class AIService {
  // Replace with your actual backend URL
  static const String _baseUrl = 'https://your-backend-api.com/api/v1';

  Future<AIStrategyGuide> generateFinancialStrategy({
    required String userId,
    required double currentBalance,
    required double monthlyBurnRate,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/generate-strategy'),
        headers: {
          'Content-Type': 'application/json',
          // 'Authorization': 'Bearer YOUR_AUTH_TOKEN',
        },
        body: jsonEncode({
          'userId': userId,
          'metrics': {
            'balance': currentBalance,
            'burnRate': monthlyBurnRate,
          }
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return AIStrategyGuide.fromJson(data['data']);
      } else {
        throw Exception('Failed to generate strategy. Status: ${response.statusCode}');
      }
    } catch (e) {
      // Return a fallback/error state if the network fails
      throw Exception('Network error: Could not reach the AI service.');
    }
  }
}