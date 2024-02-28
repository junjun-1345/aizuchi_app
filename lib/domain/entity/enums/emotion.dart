enum EmotionType {
  joyful, // 楽しい
  content, // 満足している
  neutral, // 中立
  discontent, // 不満を感じている
  sad // 悲しい
}

extension EmotionTypeExtension on EmotionType {
  static final emotionValues = {
    EmotionType.joyful: "😁",
    EmotionType.content: "🙂",
    EmotionType.neutral: "😐",
    EmotionType.discontent: "🥲",
    EmotionType.sad: "😭",
  };

  String? get emotionValue => emotionValues[this];

  static EmotionType from(String rawValue) {
    return EmotionType.values.firstWhere(
      (e) {
        return e.emotionValue == rawValue;
      },
    );
  }
}
