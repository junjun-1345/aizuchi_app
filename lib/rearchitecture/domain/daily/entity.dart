import 'package:aizuchi_app/rearchitecture/converter/timestamp_converter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'entity.freezed.dart';
part 'entity.g.dart';

@freezed
class Daily with _$Daily {
  const factory Daily({
    String? emotion,
    String? summary,
    @TimestampConverter() DateTime? createdAt,
  }) = _Daily;
  factory Daily.fromJson(Map<String, dynamic> json) => _$DailyFromJson(json);

  static String collectionName = 'dailies';
}
