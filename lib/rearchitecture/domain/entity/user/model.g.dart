// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserDataImpl _$$UserDataImplFromJson(Map<String, dynamic> json) =>
    _$UserDataImpl(
      id: json['id'] as String,
      name: json['name'] as String?,
      activeDay: json['activeDay'] as int?,
      email: json['email'] as String?,
      timer: json['timer'] as String?,
      sex: json['sex'] as String?,
      charactor: json['charactor'] as String?,
      dailyKey: json['dailyKey'] as String?,
      profession: json['profession'] as String?,
      totalMessage: json['totalMessage'] as int?,
      billing: json['billing'] ?? false,
      init: json['init'] ?? false,
      birthday:
          const TimestampConverter().fromJson(json['birthday'] as Timestamp?),
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp?),
    );

Map<String, dynamic> _$$UserDataImplToJson(_$UserDataImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'activeDay': instance.activeDay,
      'email': instance.email,
      'timer': instance.timer,
      'sex': instance.sex,
      'charactor': instance.charactor,
      'dailyKey': instance.dailyKey,
      'profession': instance.profession,
      'totalMessage': instance.totalMessage,
      'billing': instance.billing,
      'init': instance.init,
      'birthday': const TimestampConverter().toJson(instance.birthday),
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };
