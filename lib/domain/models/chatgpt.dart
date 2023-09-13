import 'package:aizuchi_app/domain/models/chatgptmessage.dart';
import 'package:aizuchi_app/domain/models/message.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'chatgpt.freezed.dart';
part 'chatgpt.g.dart';

@freezed
class Chatgpt with _$Chatgpt {
  const factory Chatgpt({
    required String model,
    required List<ChatGPTMessage> messages,
  }) = _Chatgpt;
  factory Chatgpt.fromJson(Map<String, dynamic> json) =>
      _$ChatgptFromJson(json);
}
