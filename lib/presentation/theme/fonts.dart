import 'package:aizuchi_app/presentation/theme/sizes.dart';
import 'package:flutter/material.dart';

/// フォント
class BrandFont {
  static const general = 'NotoSansJP';
}

/// 文字スタイル
class BrandText {
  static const titleS = TextStyle(
      fontSize: RawSize.p16,
      fontFamily: BrandFont.general,
      fontWeight: FontWeight.w600);
  static const title = TextStyle(
      fontSize: RawSize.p24,
      fontFamily: BrandFont.general,
      fontWeight: FontWeight.w400);
  static const titleBold = TextStyle(
    fontSize: RawSize.p24,
    fontFamily: BrandFont.general,
    fontWeight: FontWeight.w600,
  );
  static const titleLBold = TextStyle(
    fontSize: RawSize.p40,
    fontFamily: BrandFont.general,
    fontWeight: FontWeight.w600,
  );

  static const textLBold = TextStyle(
      fontSize: RawSize.p20,
      fontFamily: BrandFont.general,
      fontWeight: FontWeight.w600);
  static const textL = TextStyle(
      fontSize: RawSize.p20,
      fontFamily: BrandFont.general,
      fontWeight: FontWeight.w400);
  static const textM = TextStyle(
      fontSize: RawSize.p14,
      fontFamily: BrandFont.general,
      fontWeight: FontWeight.w400);
  static const textS = TextStyle(
    fontSize: RawSize.p8,
    fontFamily: BrandFont.general,
    fontWeight: FontWeight.w400,
  );

  static const textButton = TextStyle(
    fontSize: RawSize.p14,
    fontFamily: BrandFont.general,
    fontWeight: FontWeight.w600,
  );

  static const textCalender = TextStyle(
    fontSize: RawSize.p16,
    fontFamily: BrandFont.general,
    fontWeight: FontWeight.w500,
  );

  static const emojiCalender = TextStyle(
    fontSize: RawSize.p20,
    fontFamily: BrandFont.general,
    fontWeight: FontWeight.w500,
  );
}
