enum ClaudeModel {
  opus,
  sonnet,
  haiku,
}

extension ClaudeModdelExtension on ClaudeModel {
  static final modelValues = {
    ClaudeModel.opus: "claude-3-opus-20240229",
    ClaudeModel.sonnet: "claude-3-sonnet-20240229",
    ClaudeModel.haiku: "claude-3-haiku-20240307",
  };

  String? get modelValue => modelValues[this];

  static ClaudeModel from(String rawValue) {
    return ClaudeModel.values.firstWhere(
      (e) {
        return e.modelValue == rawValue;
      },
    );
  }
}
