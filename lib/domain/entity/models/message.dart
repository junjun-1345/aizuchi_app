import 'package:aizuchi_app/domain/entity/enums/message.dart';

class MessageEntity {
  final String id;
  final DateTime createdAt;
  final String content;
  final MessageType type;

  MessageEntity({
    required this.id,
    required this.createdAt,
    required this.content,
    required this.type,
  });
}
