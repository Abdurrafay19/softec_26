import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../widgets/smart_insight.dart';

class FinancialAiService {
  static const String _apiKey = 'api';

  Future<List<SmartInsight>> generateFinancialAnalysis({
    required double totalNetCash,
    required double currentMonthIn,
    required double currentMonthOut,
    required double prevMonthIn,
    required double prevMonthOut,
    required double burnRate,
    required List<String> upcomingGoals,
  }) async {
    final prompt = '''
You are an expert Financial AI Assistant for an SME. 
Analyze this data and provide 3 actionable insights.

Data:
Total Net Cash: \$$totalNetCash
This Month: In \$$currentMonthIn, Out \$$currentMonthOut
Last Month: In \$$prevMonthIn, Out \$$prevMonthOut
Burn Rate: \$$burnRate / month
Goals: ${upcomingGoals.join(', ')}

Output exactly 3 insights focusing on:
1. Month-over-Month comparison.
2. Runway/Burn Rate warning.
3. Goal feasibility.

Return the response ONLY as a JSON array of objects. Each object must have these exact keys:
"title" (Keep it short, max 4 words)
"subtitle" (The actionable advice, 1 sentence max)
"type" (Must be exactly one of these strings: "success", "warning", "info")
''';

    try {
      
      final model = GenerativeModel(
        model: 'gemini-2.5-flash',
        apiKey: _apiKey,
        // Force the model to return valid JSON
        generationConfig: GenerationConfig(
          responseMimeType: 'application/json',
        ),
      );

      final response = await model.generateContent([Content.text(prompt)]);
      
      // Parse the JSON string into a List of Dart objects
      if (response.text != null) {
        final List<dynamic> jsonList = jsonDecode(response.text!);
        return jsonList.map((json) => SmartInsight.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      print("AI Error: $e");
      return [
        SmartInsight(title: "Error", subtitle: "Failed to load insights.", type: "warning")
      ];
    }
  }
}