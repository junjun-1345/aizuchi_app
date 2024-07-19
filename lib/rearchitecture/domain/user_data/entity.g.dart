// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserDataImpl _$$UserDataImplFromJson(Map<String, dynamic> json) =>
    _$UserDataImpl(
      id: json['id'] as String,
      name: json['name'] as String?,
      email: json['email'] as String?,
      timer: json['timer'] as String?,
      sex: json['sex'] as String?,
      charactor: json['charactor'] as String?,
      dailyKey: json['dailyKey'] as String?,
      profession: json['profession'] as String?,
      activeDay: (json['activeDay'] as num?)?.toInt(),
      totalMessage: (json['totalMessage'] as num?)?.toInt(),
      isSubscription: json['isSubscription'] ?? false,
      init: json['init'] ?? false,
      isAssistant: json['isAssistant'] ?? false,
      isConversation: json['isConversation'] ?? false,
      isMessageOverLimit: json['isMessageOverLimit'] ?? false,
      birthday:
          const TimestampConverter().fromJson(json['birthday'] as Timestamp?),
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp?),
    );

Map<String, dynamic> _$$UserDataImplToJson(_$UserDataImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'timer': instance.timer,
      'sex': instance.sex,
      'charactor': instance.charactor,
      'dailyKey': instance.dailyKey,
      'profession': instance.profession,
      'activeDay': instance.activeDay,
      'totalMessage': instance.totalMessage,
      'isSubscription': instance.isSubscription,
      'init': instance.init,
      'isAssistant': instance.isAssistant,
      'isConversation': instance.isConversation,
      'isMessageOverLimit': instance.isMessageOverLimit,
      'birthday': const TimestampConverter().toJson(instance.birthday),
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };
