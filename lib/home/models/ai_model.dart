class AIStrategyGuide {
  final String summary;
  final List<AIAdviceSection> sections;

  AIStrategyGuide({
    required this.summary,
    required this.sections,
  });

  factory AIStrategyGuide.fromJson(Map<String, dynamic> json) {
    return AIStrategyGuide(
      summary: json['summary'] ?? '',
      sections: (json['sections'] as List<dynamic>?)
              ?.map((e) => AIAdviceSection.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class AIAdviceSection {
  final String title;
  final String content;
  final String category; // e.g., 'budget', 'burn_rate', 'goal'

  AIAdviceSection({
    required this.title,
    required this.content,
    required this.category,
  });

  factory AIAdviceSection.fromJson(Map<String, dynamic> json) {
    return AIAdviceSection(
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      category: json['category'] ?? 'general',
    );
  }
}