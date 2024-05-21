import 'package:aizuchi_app/domain/entity/enums/message.dart';
import 'package:aizuchi_app/domain/entity/models/message.dart';

class MessageModel {
  final String id;
  final DateTime createdAt;
  final String content;
  final MessageType type;

  MessageModel({
    required this.id,
    required this.createdAt,
    required this.content,
    required this.type,
  });

  static MessageModel fromEntity(MessageEntity messageEntity) => MessageModel(
        id: messageEntity.id,
        createdAt: messageEntity.createdAt,
        content: messageEntity.content,
        type: messageEntity.type,
      );

  MessageEntity toEntity() => MessageEntity(
        id: id,
        createdAt: createdAt,
        content: content,
        type: type,
      );
}
