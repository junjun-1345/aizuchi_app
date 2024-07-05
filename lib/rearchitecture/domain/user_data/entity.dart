import 'package:aizuchi_app/rearchitecture/converter/time_stamp_conveter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// 生成されるdartファイルを記述
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
  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  static String collectionName = 'users';
}
