import 'package:aizuchi_app/rearchitecture/converter/timestamp_converter.dart';
import 'package:aizuchi_app/rearchitecture/domain/enums/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'entity.freezed.dart';
part 'entity.g.dart';

@freezed
class Message with _$Message {
  const factory Message({
    required String id,
    String? content,
    MessageType? type,
    @TimestampConverter() DateTime? createdAt,
  }) = _Message;
  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  static String collectionName = 'messages';
}
