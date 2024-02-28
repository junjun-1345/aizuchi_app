import 'package:aizuchi_app/domain/entity/enums/message.dart';
import 'package:aizuchi_app/presentation/model/message_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final isAccessRestrictedProvider = StateProvider<bool>((_) => false);
final messageProvider = StateProvider<String>((_) => "");

final messageIdProvider = StateProvider<String>((_) => "");
final messageCreatedAtProvider = StateProvider<DateTime>((_) => DateTime.now());
final messageContentProvider = StateProvider<String>((_) => "");
final messageTypeProvider = StateProvider<MessageType>((_) => MessageType.user);

final messagesProvider = StateProvider.autoDispose<MessageModel>((ref) {
  final id = ref.watch(messageIdProvider);
  final createdAt = ref.watch(messageCreatedAtProvider);
  final content = ref.watch(messageContentProvider);
  final type = ref.watch(messageTypeProvider);

  return MessageModel(
    id: id,
    createdAt: createdAt,
    content: content,
    type: type,
  );
});
