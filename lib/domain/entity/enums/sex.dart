enum SexEnum {
  unknown,
  men,
  women,
  other,
}

extension SexExtension on SexEnum {
  static final sexValues = {
    SexEnum.unknown: "",
    SexEnum.men: "男性",
    SexEnum.women: "女性",
    SexEnum.other: "その他",
  };

  String? get sexValue => sexValues[this];

  static SexEnum from(String rawValue) {
    return SexEnum.values.firstWhere(
      (e) {
        return e.sexValue == rawValue;
      },
      orElse: (() {
        return SexEnum.unknown;
      }),
    );
  }
}
