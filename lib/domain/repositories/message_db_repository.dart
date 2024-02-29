import 'package:aizuchi_app/domain/entity/models/message.dart';

abstract class MessageDBRepository {
  Future<void> create(MessageEntity entity);
  Future<List<MessageEntity>> readAll();
  Future<void> delete();
  Future<void> update(MessageEntity entity);
  Future<void> deleteAll();
}
