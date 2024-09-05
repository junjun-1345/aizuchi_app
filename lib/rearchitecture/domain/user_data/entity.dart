import 'package:aizuchi_app/rearchitecture/converter/timestamp_converter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'entity.freezed.dart';
part 'entity.g.dart';

@freezed
class UserData with _$UserData {
  const factory UserData({
    required String id,
    String? name,
    String? email,
    String? timer,
    String? sex,
    String? charactor,
    String? dailyKey,
    String? profession,
    int? activeDay,
    int? totalMessage,
    @Default(false) isSubscription,
    @Default(false) init,
    @Default(false) isAssistant,
    @Default(false) isConversation,
    @Default(false) isMessageOverLimit,
    @TimestampConverter() DateTime? birthday,
    @TimestampConverter() DateTime? createdAt,
  }) = _UserData;
  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  static String collectionName = 'users';
}
