import 'package:aizuchi_app/domain/entity/enums/emotion.dart';
import 'package:aizuchi_app/domain/entity/models/message.dart';

abstract class ClaudeRepository {
  Future<String> reply(
    List<MessageEntity> messages,
    EmotionType emotion,
  );
  Future<String> createSummary(
    List<MessageEntity> messagesEntity,
  );
}
