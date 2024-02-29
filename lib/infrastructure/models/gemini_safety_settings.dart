import 'package:aizuchi_app/infrastructure/enums/gemini_safety_category.dart';
import 'package:aizuchi_app/infrastructure/enums/gemini_safety_threshold.dart';

class GeminiSafetySettings {
  final GeminiSafetyCategory category;
  final GeminiSafetyThreshold threshold;

  GeminiSafetySettings({
    required this.category,
    required this.threshold,
  });

  Map<String, dynamic> toJson() => {
        'category':
            GeminiSafetyCategoryExtension.safetyCategoryValues[category],
        'threshold':
            GeminiSafetyThresholdExtension.safetyThresholdValues[threshold],
      };

  factory GeminiSafetySettings.fromJson(Map<String, dynamic> json) =>
      GeminiSafetySettings(
        category: GeminiSafetyCategoryExtension.from(json['category']),
        threshold: GeminiSafetyThresholdExtension.from(json['threshold']),
      );
}
