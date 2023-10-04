import 'package:aizuchi_app/domain/models/message.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'message_state.g.dart';

@riverpod
class MessageStateNotifier extends _$MessageStateNotifier {
  @override
  List<Message> build() {
    // 最初のデータ
    return [];
  }
}
