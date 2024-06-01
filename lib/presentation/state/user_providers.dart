import 'package:aizuchi_app/domain/entity/enums/character.dart';
import 'package:aizuchi_app/domain/entity/enums/sex.dart';
import 'package:aizuchi_app/presentation/model/user_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userIdProvider = StateProvider<String?>((_) => null);
final userNameProvider = StateProvider<String?>((_) => null);
final userEmailProvider = StateProvider<String?>((_) => null);
final userBirthdayProvider = StateProvider<DateTime?>((_) => null);
final userSexProvider = StateProvider<SexEnum?>((_) => null);
final userIsSubscriptionProvider = StateProvider<bool?>((_) => null);
final userInitProvider = StateProvider<bool?>((_) => null);
final userCreatedAtProvider = StateProvider<DateTime?>((_) => null);
final userActiveDayProvider = StateProvider<int?>((_) => null);
final userCharactorProvider = StateProvider<CharactorEnum?>((_) => null);
final userProfessionProvider = StateProvider<String?>((_) => null);
final userDailyKeyProvider = StateProvider<String?>((_) => null);
final userIsConversationProvider = StateProvider<bool?>((_) => null);
final userIsAssistantProvider = StateProvider<bool?>((_) => true);
final userIsMessageOverLimitProvider = StateProvider<bool?>((_) => null);
final totalMessagesProvider = StateProvider<int?>((_) => 0);

final userProvider = StateProvider<UserModel>((ref) {
  final id = ref.watch(userIdProvider);
  final name = ref.watch(userNameProvider);
  final email = ref.watch(userEmailProvider);
  final birthday = ref.watch(userBirthdayProvider);
  final sex = ref.watch(userSexProvider);
  final isSubscription = ref.watch(userIsSubscriptionProvider);
  final init = ref.watch(userInitProvider);
  final createdAt = ref.watch(userCreatedAtProvider);
  final activeDay = ref.watch(userActiveDayProvider);
  final charactor = ref.watch(userCharactorProvider);

  final profession = ref.watch(userProfessionProvider);
  final dailyKey = ref.watch(userDailyKeyProvider);
  final isConversation = ref.watch(userIsConversationProvider);
  final isAssistant = ref.watch(userIsAssistantProvider);
  final isMessageOverLimit = ref.watch(userIsMessageOverLimitProvider);
  final totalMessages = ref.watch(totalMessagesProvider);
  return UserModel(
    id: id ?? "",
    name: name ?? "",
    email: email ?? "",
    birthday: birthday,
    sex: sex ?? SexEnum.unknown,
    isSubscription: isSubscription ?? false,
    init: init ?? false,
    createdAt: createdAt ?? DateTime.now(),
    activeDay: activeDay ?? 0,
    charactor: charactor ?? CharactorEnum.unknown,
    profession: profession ?? "",
    dailyKey: dailyKey ?? "",
    isConversation: isConversation ?? false,
    isAssistant: isAssistant ?? true,
    isMessageOverLimit: isMessageOverLimit ?? false,
    totalMessages: totalMessages ?? 0,
  );
});
