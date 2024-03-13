import 'package:aizuchi_app/domain/entity/enums/character.dart';
import 'package:aizuchi_app/domain/entity/enums/sex.dart';
import 'package:aizuchi_app/presentation/model/user_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userIdProvider = StateProvider<String>((_) => "");
final userNameProvider = StateProvider<String>((_) => "");
final userEmailProvider = StateProvider<String>((_) => "");
final userBirthdayProvider = StateProvider<DateTime>((_) => DateTime.now());
final userSexProvider = StateProvider<SexEnum>((_) => SexEnum.unknown);
final userBillingProvider = StateProvider<bool>((_) => false);
final userInitProvider = StateProvider<bool>((_) => false);
final userCreatedAtProvider = StateProvider<DateTime>((_) => DateTime.now());
final userActiveDayProvider = StateProvider<int>((_) => 0);
final userCharactorProvider =
    StateProvider<CharactorEnum>((_) => CharactorEnum.unknown);
final professionProvider = StateProvider<String>((_) => "");
final dailyKeyProvider = StateProvider<String>((_) => "");
final isConversationProvider = StateProvider<bool>((_) => false);
final isAssistantProvider = StateProvider<bool>((_) => true);
final isMessageOverLimitProvider = StateProvider<bool>((_) => false);
final totalMessagesProvider = StateProvider<int>((_) => 0);

final userProvider = StateProvider<UserModel>((ref) {
  final id = ref.watch(userIdProvider);
  final name = ref.watch(userNameProvider);
  final email = ref.watch(userEmailProvider);
  final birthday = ref.watch(userBirthdayProvider);
  final sex = ref.watch(userSexProvider);
  final billing = ref.watch(userBillingProvider);
  final init = ref.watch(userInitProvider);
  final createdAt = ref.watch(userCreatedAtProvider);
  final activeDay = ref.watch(userActiveDayProvider);
  final charactor = ref.watch(userCharactorProvider);
  final profession = ref.watch(professionProvider);
  final dailyKey = ref.watch(dailyKeyProvider);
  final isConversation = ref.watch(isConversationProvider);
  final isAssistant = ref.watch(isAssistantProvider);
  final isMessageOverLimit = ref.watch(isMessageOverLimitProvider);
  final totalMessages = ref.watch(totalMessagesProvider);
  return UserModel(
    id: id,
    name: name,
    email: email,
    birthday: birthday,
    sex: sex,
    billing: billing,
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
});
