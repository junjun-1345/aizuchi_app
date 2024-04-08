import 'package:aizuchi_app/domain/entity/enums/character.dart';
import 'package:aizuchi_app/domain/entity/enums/sex.dart';
import 'package:aizuchi_app/domain/entity/models/user.dart';

class UserModel {
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

  const UserModel({
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

  UserModel copyWith({
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
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      birthday: birthday ?? this.birthday,
      sex: sex ?? this.sex,
      isSubscription: isSubscription ?? this.isSubscription,
      init: init ?? this.init,
      createdAt: createdAt ?? this.createdAt,
      activeDay: activeDay ?? this.activeDay,
      charactor: charactor ?? this.charactor,
      profession: profession ?? this.profession,
      dailyKey: dailyKey ?? this.dailyKey,
      isConversation: isConversation ?? this.isConversation,
      isAssistant: isAssistant ?? this.isAssistant,
      isMessageOverLimit: isMessageOverLimit ?? this.isMessageOverLimit,
    );
  }

  static UserModel fromEntity(UserEntity userEntity) => UserModel(
        id: userEntity.id,
        name: userEntity.name,
        email: userEntity.email,
        birthday: userEntity.birthday,
        sex: userEntity.sex,
        isSubscription: userEntity.isSubscription,
        init: userEntity.init,
        createdAt: userEntity.createdAt,
        activeDay: userEntity.activeDay,
        charactor: userEntity.charactor,
        profession: userEntity.profession,
        dailyKey: userEntity.dailyKey,
        isConversation: userEntity.isConversation,
        isAssistant: userEntity.isAssistant,
        isMessageOverLimit: userEntity.isMessageOverLimit,
      );

  UserEntity toEntity() => UserEntity(
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
      );
}
