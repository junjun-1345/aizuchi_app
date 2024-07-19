// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DailyImpl _$$DailyImplFromJson(Map<String, dynamic> json) => _$DailyImpl(
      emotion: json['emotion'] as String?,
      summary: json['summary'] as String?,
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp?),
    );

Map<String, dynamic> _$$DailyImplToJson(_$DailyImpl instance) =>
    <String, dynamic>{
      'emotion': instance.emotion,
      'summary': instance.summary,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };
