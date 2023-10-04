import 'package:freezed_annotation/freezed_annotation.dart';
part 'appuser.freezed.dart';
part 'appuser.g.dart';

@freezed
class AppUser with _$AppUser {
  const factory AppUser({
    // ユーザー情報
    @Default('') String id,
    @Default('') String email,
    @Default('') String name,
    @Default(0) int sex,
    @Default('') String birhtDay,
    @Default(false) bool init,
    // 課金状況
    @Default(false) bool billing,
    // ログ
    @Default(0) int activeDay,
    @Default('') String registerDay,
    @Default(0) int wordIndex,
    // 指定時刻
    @Default('') String timer,
  }) = _AppUser;
  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
}
