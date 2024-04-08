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
  });
}
