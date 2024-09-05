import 'package:aizuchi_app/domain/entity/enums/character.dart';
import 'package:aizuchi_app/domain/entity/enums/platform.dart';
import 'package:aizuchi_app/domain/entity/enums/sex.dart';
import 'package:aizuchi_app/domain/entity/models/user.dart';
import 'package:aizuchi_app/domain/repositories/auth_repository.dart';
import 'package:aizuchi_app/domain/repositories/daily_db_repository.dart';
import 'package:aizuchi_app/domain/repositories/local_db_repository.dart';
import 'package:aizuchi_app/domain/repositories/message_db_repository.dart';
import 'package:aizuchi_app/domain/repositories/remote_config.dart';
import 'package:aizuchi_app/domain/repositories/shared_preferences_repository.dart';
import 'package:aizuchi_app/domain/repositories/user_db_repository.dart';
import 'package:aizuchi_app/domain/usecases/users_usecase.dart';
import 'package:aizuchi_app/infrastructure/enums/remote_config_key.dart';
import 'package:aizuchi_app/infrastructure/enums/shared_preferences_key.dart';

class UsersInteractor implements UsersUsecase {
  final AuthRepository authRepository;
  final DailyDBRepository dailyDBRepository;
  final MessageDBRepository messageDBRepository;
  final UserDBRepository userDBRepository;
  final LocalDBRepository localDBRepository;
  final SharedPreferencesRepository sharedPreferencesRepository;
  final RemoteConfigRepository remoteConfigRepository;

  UsersInteractor(
      this.userDBRepository,
      this.dailyDBRepository,
      this.messageDBRepository,
      this.authRepository,
      this.localDBRepository,
      this.sharedPreferencesRepository,
      this.remoteConfigRepository);

  @override
  Future<void> signUpWith(
    PlatformType platform,
    String password,
    UserEntity user,
  ) async {
    // 既存はfalse 新規はtrue を返す。
    switch (platform) {
      case PlatformType.google:
        await authRepository.signUpWithGoogle();
        break;
      case PlatformType.apple:
        await authRepository.signUpWithApple();
        break;
      case PlatformType.email:
        await authRepository.signUpWithEmail(password, user);
        break;
      default:
        throw '不正なサインアップ方法です';
    }
    final userData = await userDBRepository.read();
    if (userData != null) {
      authRepository.signOut();
      throw '既に登録されているメールアドレスです。';
    }
    sharedPreferencesRepository.save(SharedPreferencesKey.isRegistering, true);
  }

  @override
  Future<void> signInWith(
    PlatformType platform,
    String password,
    UserEntity user,
  ) async {
    switch (platform) {
      case PlatformType.google:
        await authRepository.signInWithGoogle();
        break;
      case PlatformType.apple:
        await authRepository.signInWithApple();
        break;
      case PlatformType.email:
        await authRepository.signInWithEmail(password, user);
        break;
      default:
        throw '不正なログイン方法です';
    }

    final userData = await userDBRepository.read();
    if (userData == null) {
      delete();
      throw '未登録のメールアドレスです。';
    }
  }

  @override
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
  }) async {
    return await userDBRepository.update(
      id: id,
      name: name,
      email: email,
      birthday: birthday,
      sex: sex,
      isSubscription: isSubscription,
      init: init,
      createdAt: createdAt,
      activeDay: activeDay,
      charactor: charactor,
      profession: profession,
      dailyKey: dailyKey,
      isConversation: isConversation,
      isAssistant: isAssistant,
      isMessageOverLimit: isMessageOverLimit,
      totalMessages: totalMessages,
    );
  }

  @override
  Future<void> signOut() {
    localDBRepository.setIsSignUpFalse();
    return authRepository.signOut();
  }

  @override
  Future<void> delete() async {
    await userDBRepository.delete();
    await authRepository.accountDalete();
  }

  @override
  Future<UserEntity?> read() async {
    final entity = await userDBRepository.read();
    final messageDBDocumentCount = await messageDBRepository.getDocumentCount();
    final dailyDBDocumentCount = await dailyDBRepository.getDocumentCount();
    final newEntity = entity?.copyWith(
      totalMessages: messageDBDocumentCount,
      activeDay: dailyDBDocumentCount,
    );
    return newEntity;
  }

  @override
  Future<UserEntity> register(UserEntity form) async {
    final user = UserEntity(
      id: "",
      name: form.name,
      email: "",
      birthday: form.birthday,
      sex: form.sex,
      isSubscription: false,
      init: true,
      createdAt: DateTime.now(),
      activeDay: 0,
      charactor: CharactorEnum.mouhu,
      profession: form.profession,
      dailyKey: "",
      isConversation: false,
      isAssistant: true,
      isMessageOverLimit: false,
      totalMessages: 0,
    );

    await userDBRepository.create(user);
    await sharedPreferencesRepository.save(
        SharedPreferencesKey.isRegistering, false);
    return user;
  }

  @override
  String createKey() {
    final DateTime now = DateTime.now();
    final String key = "${now.year}_${now.month}_${now.day}";
    return key;
  }

  @override
  Future<void> updateEmail(String email) {
    return authRepository.updateEmail(email);
  }

  @override
  Future<String?> readEmail() async {
    return await authRepository.readEmail();
  }

  @override
  Future<void> updatePassword(String email) {
    return authRepository.updatePassword(email);
  }

  @override
  Future<String> isConversationStart(String newDailyKey) async {
    await userDBRepository.update(isConversation: true, dailyKey: newDailyKey);
    return newDailyKey;
  }

  @override
  Future<int> getMessageLimit() async {
    final messageLimit =
        await remoteConfigRepository.fetch<int>(RemoteConfigKey.messageLimit);
    return messageLimit ?? 100;
  }

  @override
  Future<bool> getIsMessageLimit() async {
    final isMessageLimit = await remoteConfigRepository
        .fetch<bool>(RemoteConfigKey.isMessageLimit);
    return isMessageLimit ?? false;
  }
}
