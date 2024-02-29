import 'package:aizuchi_app/infrastructure/models/gemini_content.dart';
import 'package:aizuchi_app/infrastructure/models/gemini_generation_config.dart';
import 'package:aizuchi_app/infrastructure/models/gemini_safety_settings.dart';

class GeminiModel {
  final List<GeminiContent> contents;
  final List<GeminiSafetySettings> safetySettings;
  final GeminiGenerationConfig generationConfig;

  GeminiModel({
    required this.contents,
    required this.safetySettings,
    required this.generationConfig,
  });

  Map<String, dynamic> toJson() => {
        'contents': contents.map((e) => e.toJson()).toList(),
        'safety_settings': safetySettings.map((e) => e.toJson()).toList(),
        'generation_config': generationConfig.toJson(),
      };

  factory GeminiModel.fromJson(Map<String, dynamic> json) => GeminiModel(
        contents: List<GeminiContent>.from(
            json['contents'].map((content) => GeminiContent.fromJson(content))),
        safetySettings: List<GeminiSafetySettings>.from(json['safety_settings']
            .map((safetySetting) =>
                GeminiSafetySettings.fromJson(safetySetting))),
        generationConfig:
            GeminiGenerationConfig.fromJson(json['generation_config']),
      );
}
