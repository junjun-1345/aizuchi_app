import 'package:aizuchi_app/rearchitecture/util/converter/timestamp_converter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'entity.freezed.dart';
part 'entity.g.dart';

@freezed
class UserData with _$UserData {
  const factory UserData({
    required String id,
    String? name,
    int? activeDay,
    String? email,
    String? timer,
    String? sex,
    String? charactor,
    String? dailyKey,
    String? profession,
    int? totalMessage,
    @Default(false) billing,
    @Default(false) init,
    @TimestampConverter() DateTime? birthday,
    @TimestampConverter() DateTime? createdAt,
  }) = _UserData;

  // TODO: UserDataを生成してからじゃないとエラーになる?
  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  static String collectionName = 'users';
}
