enum GeminiSafetyThreshold {
  blockLowAndAbove,
  blockMediumAndAbove,
  blockHighAndAbove,
  unknown,
}

extension GeminiSafetyThresholdExtension on GeminiSafetyThreshold {
  static final safetyThresholdValues = {
    GeminiSafetyThreshold.blockLowAndAbove: "BLOCK_LOW_AND_ABOVE",
    GeminiSafetyThreshold.blockMediumAndAbove: "BLOCK_MEDIUM_AND_ABOVE",
    GeminiSafetyThreshold.blockHighAndAbove: "BLOCK_HIGH_AND_ABOVE",
    GeminiSafetyThreshold.unknown: "",
  };

  String? get safetyThresholdValue => safetyThresholdValues[this];

  static GeminiSafetyThreshold from(String rawValue) {
    return GeminiSafetyThreshold.values.firstWhere(
      (e) {
        return e.safetyThresholdValue == rawValue;
      },
      orElse: (() {
        return GeminiSafetyThreshold.unknown;
      }),
    );
  }
}
