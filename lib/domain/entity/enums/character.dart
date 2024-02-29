enum CharactorEnum {
  unknown,
  mouhu,
}

extension CharactorExtension on CharactorEnum {
  static final charactorValues = {
    CharactorEnum.unknown: "",
    CharactorEnum.mouhu: "もうふ",
  };

  String? get charactorValue => charactorValues[this];

  static CharactorEnum from(String rawValue) {
    return CharactorEnum.values.firstWhere(
      (e) {
        return e.charactorValue == rawValue;
      },
      orElse: (() {
        return CharactorEnum.unknown;
      }),
    );
  }
}
