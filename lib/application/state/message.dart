import 'package:aizuchi_app/domain/models/message.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'message.g.dart';

@riverpod
class MessageNotifier extends _$MessageNotifier {
  @override
  List<Message> build() {
    // 最初のデータ
    return [
      Message(
          createdDate: 20230827,
          createdTime: 1800,
          role: "user",
          content: "テストユーザー"),
      Message(
          createdDate: 20230827,
          createdTime: 1700,
          role: "assistant",
          content: "テストシステム"),
    ];
  }
}
