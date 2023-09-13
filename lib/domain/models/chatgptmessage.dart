import 'package:freezed_annotation/freezed_annotation.dart';
part 'chatgptmessage.freezed.dart';
part 'chatgptmessage.g.dart';

@freezed
class ChatGPTMessage with _$ChatGPTMessage {
  const factory ChatGPTMessage({
    required String role,
    required String content,
  }) = _ChatGPTMessage;
  factory ChatGPTMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatGPTMessageFromJson(json);

  static fromMap(Map<String, dynamic> data) {}
}
