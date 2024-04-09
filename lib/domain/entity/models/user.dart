import 'package:aizuchi_app/domain/entity/enums/character.dart';
import 'package:aizuchi_app/domain/entity/enums/sex.dart';

class UserEntity {
  final String id;
  final String name;
  final String email;
  final DateTime birthday;
  final SexEnum sex;
  final bool isSubscription;
  final bool init;
  final DateTime createdAt;
  final int activeDay;
  final CharactorEnum charactor;
  final String profession;
  final String dailyKey;
  final bool isConversation;
  final bool isAssistant;
  final bool isMessageOverLimit;
  final int totalMessages;

  UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.birthday,
    required this.sex,
    required this.isSubscription,
    required this.init,
    required this.createdAt,
    required this.activeDay,
    required this.charactor,
    required this.profession,
    required this.dailyKey,
    required this.isConversation,
    required this.isAssistant,
    required this.isMessageOverLimit,
    required this.totalMessages,
  });

  UserEntity copyWith({
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
  }) =>
      UserEntity(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        name: name ?? this.name,
        email: email ?? this.email,
        birthday: birthday ?? this.birthday,
        sex: sex ?? this.sex,
        isSubscription: isSubscription ?? this.isSubscription,
        init: init ?? this.init,
        activeDay: activeDay ?? this.activeDay,
        charactor: charactor ?? this.charactor,
        profession: profession ?? this.profession,
        dailyKey: dailyKey ?? this.dailyKey,
        isConversation: isConversation ?? this.isConversation,
        isAssistant: isAssistant ?? this.isAssistant,
        isMessageOverLimit: isMessageOverLimit ?? this.isMessageOverLimit,
        totalMessages: totalMessages ?? this.totalMessages,
      );
}
