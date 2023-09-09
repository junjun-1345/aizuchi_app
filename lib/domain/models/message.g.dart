// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Message _$$_MessageFromJson(Map<String, dynamic> json) => _$_Message(
      createdDate: json['createdDate'] as int,
      createdTime: json['createdTime'] as int,
      role: json['role'] as String,
      content: json['content'] as String,
    );

Map<String, dynamic> _$$_MessageToJson(_$_Message instance) =>
    <String, dynamic>{
      'createdDate': instance.createdDate,
      'createdTime': instance.createdTime,
      'role': instance.role,
      'content': instance.content,
    };
