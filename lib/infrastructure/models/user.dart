import 'package:aizuchi_app/domain/entity/enums/character.dart';
import 'package:aizuchi_app/domain/entity/enums/sex.dart';
import 'package:aizuchi_app/domain/entity/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserFields {
  static final List<String> values = [
    id,
    name,
    email,
    birthday,
    sex,
    isSubscription,
    init,
    createdAt,
    activeDay,
    charactor,
    profession,
    dailyKey,
    isConversation,
    isAssistant,
    isMessageOverLimit,
  ];

  static const String id = 'id';
  static const String name = 'name';
  static const String email = 'email';
  static const String birthday = 'birthday';
  static const String sex = 'sex';
  static const String isSubscription = 'isSubscription';
  static const String init = 'init';
  static const String createdAt = 'createdAt';
  static const String activeDay = 'activeDay';
  static const String charactor = 'charactor';
  static const String profession = 'profession';
  static const String dailyKey = 'dailyKey';
  static const String isConversation = 'isConversation';
  static const String isAssistant = 'isAssistant';
  static const String isMessageOverLimit = 'isMessageOverLimit';
}

class UserData {
  final String id;
  final String name;
  final String email;
  final Timestamp birthday;
  final String sex;
  final bool isSubscription;
  final bool init;
  final Timestamp createdAt;
  final int activeDay;
  final String charactor;
  final String profession;
  final String dailyKey;
  final bool isConversation;
  final bool isAssistant;
  final bool isMessageOverLimit;

  UserData({
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

  UserData copy({
    String? id,
    String? name,
    String? email,
    Timestamp? birthday,
    String? sex,
    bool? isSubscription,
    bool? init,
    Timestamp? createdAt,
    int? activeDay,
    String? charactor,
    String? profession,
    String? dailyKey,
    bool? isConversation,
    bool? isAssistant,
    bool? isMessageOverLimit,
  }) =>
      UserData(
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
      );

  static UserData fromJson(Map<String, Object?> json) => UserData(
        id: json[UserFields.id] as String,
        name: json[UserFields.name] as String,
        email: json[UserFields.email] as String,
        birthday: json[UserFields.createdAt] as Timestamp,
        sex: json[UserFields.sex] as String,
        isSubscription: json[UserFields.isSubscription] as bool,
        init: json[UserFields.init] as bool,
        createdAt: json[UserFields.createdAt] as Timestamp,
        activeDay: json[UserFields.activeDay] as int,
        charactor: json[UserFields.charactor] as String,
        profession: json[UserFields.profession] as String,
        dailyKey: json[UserFields.dailyKey] as String,
        isConversation: json[UserFields.isConversation] as bool,
        isAssistant: json[UserFields.isAssistant] as bool,
        isMessageOverLimit: json[UserFields.isMessageOverLimit] as bool,
      );

  Map<String, Object?> toJson() => {
        UserFields.id: id,
        UserFields.name: name,
        UserFields.email: email,
        UserFields.birthday: birthday,
        UserFields.sex: sex,
        UserFields.isSubscription: isSubscription,
        UserFields.init: init,
        UserFields.createdAt: createdAt,
        UserFields.activeDay: activeDay,
        UserFields.charactor: charactor,
        UserFields.profession: profession,
        UserFields.dailyKey: dailyKey,
        UserFields.isConversation: isConversation,
        UserFields.isAssistant: isAssistant,
        UserFields.isMessageOverLimit: isMessageOverLimit,
      };

  static UserData fromEntity(UserEntity entity) => UserData(
        id: entity.id,
        name: entity.name,
        email: entity.email,
        birthday: Timestamp.fromDate(entity.birthday),
        sex: entity.sex.sexValue!,
        isSubscription: entity.isSubscription,
        init: entity.init,
        createdAt: Timestamp.fromDate(entity.createdAt),
        activeDay: entity.activeDay,
        charactor: entity.charactor.charactorValue!,
        profession: entity.profession,
        dailyKey: entity.dailyKey,
        isConversation: entity.isConversation,
        isAssistant: entity.isAssistant,
        isMessageOverLimit: entity.isMessageOverLimit,
      );

  UserEntity toEntity() => UserEntity(
        id: id,
        name: name,
        email: email,
        birthday: birthday.toDate(),
        sex: SexExtension.from(sex),
        isSubscription: isSubscription,
        init: init,
        createdAt: createdAt.toDate(),
        activeDay: activeDay,
        charactor: CharactorExtension.from(charactor),
        profession: profession,
        dailyKey: dailyKey,
        isConversation: isConversation,
        isAssistant: isAssistant,
        isMessageOverLimit: isMessageOverLimit,
      );
}
