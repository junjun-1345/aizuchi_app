import 'package:flutter/material.dart';

enum VerticalType {
  top,
  bottom,
  none,
  all,
}

extension VerticalExtension on VerticalType {
  static final verticalValues = {
    VerticalType.top: const BorderRadius.vertical(
      top: Radius.circular(8),
    ),
    VerticalType.bottom: const BorderRadius.vertical(
      bottom: Radius.circular(8),
    ),
    VerticalType.none: BorderRadius.zero,
    VerticalType.all: const BorderRadius.all(Radius.circular(8)),
  };

  BorderRadius? get verticalValue => verticalValues[this];
}
