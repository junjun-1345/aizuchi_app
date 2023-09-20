import 'package:freezed_annotation/freezed_annotation.dart';
part 'message.freezed.dart';
part 'message.g.dart';

@freezed
class Message with _$Message {
  const factory Message({
    required String key,
    required DateTime createdAt,
    required String role,
    required String content,
  }) = _Message;
  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  static fromMap(Map<String, dynamic> data) {}
}
