enum GeminiSafetyCategory {
  harmCategorySexuallyExplicit,
  harmCategoryHateSpeech,
  harmCategoryHarassment,
  harmCategoryDangerousContent,
  unknown,
}

extension GeminiSafetyCategoryExtension on GeminiSafetyCategory {
  static final safetyCategoryValues = {
    GeminiSafetyCategory.harmCategorySexuallyExplicit:
        "HARM_CATEGORY_SEXUALLY_EXPLICIT",
    GeminiSafetyCategory.harmCategoryHateSpeech: "HARM_CATEGORY_HATE_SPEECH",
    GeminiSafetyCategory.harmCategoryHarassment: "HARM_CATEGORY_HARASSMENT",
    GeminiSafetyCategory.harmCategoryDangerousContent:
        "HARM_CATEGORY_DANGEROUS_CONTENT",
    GeminiSafetyCategory.unknown: "",
  };

  String? get safetyCategoryValue => safetyCategoryValues[this];

  static GeminiSafetyCategory from(String rawValue) {
    return GeminiSafetyCategory.values.firstWhere(
      (e) {
        return e.safetyCategoryValue == rawValue;
      },
      orElse: (() {
        return GeminiSafetyCategory.unknown;
      }),
    );
  }
}
