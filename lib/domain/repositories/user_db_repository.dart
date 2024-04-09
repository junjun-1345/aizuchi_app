import 'package:aizuchi_app/domain/entity/enums/character.dart';
import 'package:aizuchi_app/domain/entity/enums/sex.dart';
import 'package:aizuchi_app/domain/entity/models/user.dart';

abstract class UserDBRepository {
  Future<void> create(UserEntity form);
  Future<UserEntity> read();
  Future<void> delete();
  Future<UserEntity> update({
    String? id,
    String? name,
    String? email,
    DateTime? birthday,
    SexEnum? sex,
    bool? isSubscription,
    bool? init,
    DateTime? createdAt,
    int? activeDay,
    CharactorEnum? charactor,
    String? profession,
    String? dailyKey,
    bool? isConversation,
    bool? isAssistant,
    bool? isMessageOverLimit,
    int? totalMessages,
  });
}
