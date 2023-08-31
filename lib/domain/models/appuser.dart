import 'package:freezed_annotation/freezed_annotation.dart';
part 'appuser.freezed.dart';
part 'appuser.g.dart';

@freezed
class AppUser with _$AppUser {
  const factory AppUser({
    // ユーザー入力情報
    required String? name,
    required int? sex,
    required DateTime? birhtDay,
    // 課金状況
    required String? id,
    required bool? billing,
    // ログ
    required int? activeDay,
    required DateTime? registerDay,
    required int? wordIndex,
    // 指定時刻
    required DateTime? timer,
  }) = _AppUser;
  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
}
