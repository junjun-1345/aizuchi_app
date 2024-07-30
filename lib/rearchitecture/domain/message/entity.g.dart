// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageImpl _$$MessageImplFromJson(Map<String, dynamic> json) =>
    _$MessageImpl(
      id: json['id'] as String,
      content: json['content'] as String?,
      type: $enumDecodeNullable(_$MessageTypeEnumMap, json['type']),
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp?),
    );

Map<String, dynamic> _$$MessageImplToJson(_$MessageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'type': _$MessageTypeEnumMap[instance.type],
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };

const _$MessageTypeEnumMap = {
  MessageType.user: 'user',
  MessageType.assistant: 'assistant',
  MessageType.emotion: 'emotion',
  MessageType.datetime: 'datetime',
};
