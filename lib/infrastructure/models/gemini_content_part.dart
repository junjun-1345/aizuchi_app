class GeminiContentParts {
  final String text;

  GeminiContentParts({
    required this.text,
  });

  Map<String, dynamic> toJson() => {
        'text': text,
      };

  factory GeminiContentParts.fromJson(Map<String, dynamic> json) =>
      GeminiContentParts(
        text: json['text'],
      );
}
