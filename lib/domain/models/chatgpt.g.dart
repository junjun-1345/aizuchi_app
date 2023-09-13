// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chatgpt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Chatgpt _$$_ChatgptFromJson(Map<String, dynamic> json) => _$_Chatgpt(
      model: json['model'] as String,
      messages: (json['messages'] as List<dynamic>)
          .map((e) => ChatGPTMessage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_ChatgptToJson(_$_Chatgpt instance) =>
    <String, dynamic>{
      'model': instance.model,
      'messages': instance.messages,
    };
