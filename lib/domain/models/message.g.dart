// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Message _$$_MessageFromJson(Map<String, dynamic> json) => _$_Message(
      createdAt: DateTime.parse(json['createdAt'] as String),
      role: json['role'] as String,
      content: json['content'] as String,
    );

Map<String, dynamic> _$$_MessageToJson(_$_Message instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt.toIso8601String(),
      'role': instance.role,
      'content': instance.content,
    };
