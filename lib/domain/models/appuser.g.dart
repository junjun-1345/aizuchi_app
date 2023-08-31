// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appuser.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AppUser _$$_AppUserFromJson(Map<String, dynamic> json) => _$_AppUser(
      name: json['name'] as String?,
      sex: json['sex'] as int?,
      birhtDay: json['birhtDay'] == null
          ? null
          : DateTime.parse(json['birhtDay'] as String),
      id: json['id'] as String?,
      billing: json['billing'] as bool?,
      activeDay: json['activeDay'] as int?,
      registerDay: json['registerDay'] == null
          ? null
          : DateTime.parse(json['registerDay'] as String),
      wordIndex: json['wordIndex'] as int?,
      timer: json['timer'] == null
          ? null
          : DateTime.parse(json['timer'] as String),
    );

Map<String, dynamic> _$$_AppUserToJson(_$_AppUser instance) =>
    <String, dynamic>{
      'name': instance.name,
      'sex': instance.sex,
      'birhtDay': instance.birhtDay?.toIso8601String(),
      'id': instance.id,
      'billing': instance.billing,
      'activeDay': instance.activeDay,
      'registerDay': instance.registerDay?.toIso8601String(),
      'wordIndex': instance.wordIndex,
      'timer': instance.timer?.toIso8601String(),
    };
