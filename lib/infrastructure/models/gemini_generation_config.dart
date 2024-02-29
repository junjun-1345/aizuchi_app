class GeminiGenerationConfig {
  final double temperature;
  final double topP;
  final int topK;
  final int maxOutputTokens;
  final List<String> stopSequences;

  GeminiGenerationConfig({
    required this.temperature,
    required this.topP,
    required this.topK,
    required this.maxOutputTokens,
    required this.stopSequences,
  });

  Map<String, dynamic> toJson() => {
        'temperature': temperature,
        'topP': topP,
        'topK': topK,
        'maxOutputTokens': maxOutputTokens,
        'stopSequences': stopSequences,
      };

  factory GeminiGenerationConfig.fromJson(Map<String, dynamic> json) =>
      GeminiGenerationConfig(
        temperature: json['temperature'],
        topP: json['topP'],
        topK: json['topK'],
        maxOutputTokens: json['maxOutputTokens'],
        stopSequences: json['stopSequences'],
      );
}
