import 'package:aizuchi_app/domain/models/message.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessageNotifier extends StateNotifier<List<Message>> {
  MessageNotifier()
      : super([
          Message(
              createdDate: 20230827,
              cretedTime: 1800,
              role: "user",
              content: "テストユーザー"),
          Message(
              createdDate: 20230827,
              cretedTime: 1700,
              role: "assistant",
              content: "テストシステム"),
        ]);

  void addMessage(Message message) {
    state = [...state, message];
  }
}

final messageProvider =
    StateNotifierProvider<MessageNotifier, List<Message>>((ref) {
  return MessageNotifier();
});
