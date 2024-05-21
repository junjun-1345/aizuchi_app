enum EmotionType {
  sad, // 悲しい
  discontent, // 不満を感じている
  neutral, // 中立
  content, // 満足している
  joyful, // 楽しい
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
