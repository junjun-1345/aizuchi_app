import 'package:aizuchi_app/domain/entity/enums/character.dart';
import 'package:aizuchi_app/domain/entity/enums/platform.dart';
import 'package:aizuchi_app/domain/entity/enums/sex.dart';
import 'package:aizuchi_app/domain/entity/models/user.dart';

abstract class UsersUsecase {
  Future<void> signUpWith(
    PlatformType platform,
    String password,
    UserEntity user,
  );
  Future<void> signInWith(
    PlatformType platform,
    String password,
    UserEntity user,
  );
  Future<void> signOut();
  Future<UserEntity> register(UserEntity user);
  Future<void> delete(String id);
  Future<UserEntity> read();
  Future<UserEntity> update({
    String? id,
    String? name,
    String? email,
    DateTime? birthday,
    SexEnum? sex,
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
    bool? isSubscription,
  });
  String createKey();
}
