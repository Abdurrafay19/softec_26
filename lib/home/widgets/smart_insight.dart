class SmartInsight {
  final String title;
  final String subtitle;
  final String type; // We will instruct Gemini to use: 'success', 'warning', or 'info'

  SmartInsight({
    required this.title,
    required this.subtitle,
    required this.type,
  });

  factory SmartInsight.fromJson(Map<String, dynamic> json) {
    return SmartInsight(
      title: json['title'] ?? 'Insight',
      subtitle: json['subtitle'] ?? 'Data unavailable',
      type: json['type'] ?? 'info',
    );
  }
}