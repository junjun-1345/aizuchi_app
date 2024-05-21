import 'package:aizuchi_app/domain/entity/models/message.dart';

abstract class GeminiRepository {
  Future<String> reply(List<MessageEntity> messages);
  Future<String> createSummary(String message);
}
