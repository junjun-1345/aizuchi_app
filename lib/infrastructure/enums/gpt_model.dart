enum GptModel {
  gpt4,
  gpt4TurboPreview,
  gpt35Turbo,
}

extension GptRoleExtension on GptModel {
  static final roleValues = {
    GptModel.gpt4: "gpt-4",
    GptModel.gpt4TurboPreview: "gpt-4-turbo-preview",
    GptModel.gpt35Turbo: "gpt-3.5-turbo",
  };

  String? get roleValue => roleValues[this];

  static GptModel from(String rawValue) {
    return GptModel.values.firstWhere(
      (e) {
        return e.roleValue == rawValue;
      },
    );
  }
}
