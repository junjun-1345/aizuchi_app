// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appuser.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AppUser _$$_AppUserFromJson(Map<String, dynamic> json) => _$_AppUser(
      id: json['id'] as String? ?? '',
      email: json['email'] as String? ?? '',
      name: json['name'] as String? ?? '',
      sex: json['sex'] as int? ?? 0,
      birhtDay: json['birhtDay'] as String? ?? '',
      init: json['init'] as bool? ?? false,
      billing: json['billing'] as bool? ?? false,
      activeDay: json['activeDay'] as int? ?? 0,
      registerDay: json['registerDay'] as String? ?? '',
      wordIndex: json['wordIndex'] as int? ?? 0,
      timer: json['timer'] as String? ?? '',
    );

Map<String, dynamic> _$$_AppUserToJson(_$_AppUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'sex': instance.sex,
      'birhtDay': instance.birhtDay,
      'init': instance.init,
      'billing': instance.billing,
      'activeDay': instance.activeDay,
      'registerDay': instance.registerDay,
      'wordIndex': instance.wordIndex,
      'timer': instance.timer,
    };
