enum Emotion {
  unacceptable,
  poor,
  fair,
  good,
  excellent,
}

extension EmotionIconExtension on Emotion {
  String get name {
    return switch (this) {
      Emotion.unacceptable => "😭",
      Emotion.poor => "🥲",
      Emotion.fair => "😐",
      Emotion.good => "🙂",
      Emotion.excellent => "😁",
    };
  }
}
