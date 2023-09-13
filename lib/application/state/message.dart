import 'package:aizuchi_app/domain/models/message.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'message.g.dart';

@riverpod
class MessageNotifier extends _$MessageNotifier {
  @override
  List<Message> build() {
    // 最初のデータ
    return [];
  }
}
