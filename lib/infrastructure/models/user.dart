import 'package:aizuchi_app/domain/entity/enum/character.dart';
import 'package:aizuchi_app/domain/entity/enum/sex.dart';
import 'package:aizuchi_app/domain/entity/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserFields {
  static final List<String> values = [
    id,
    name,
    email,
    birthday,
    sex,
    billing,
    init,
    createdAt,
    activeDay,
    charactor,
    profession,
  ];

  static const String id = 'id';
  static const String name = 'name';
  static const String email = 'email';
  static const String birthday = 'birthday';
  static const String sex = 'sex';
  static const String billing = 'billing';
  static const String init = 'init';
  static const String createdAt = 'createdAt';
  static const String activeDay = 'activeDay';
  static const String charactor = 'charactor';
  static const String profession = 'profession';
}

class UserData {
  final String id;
  final String name;
  final String email;
  final Timestamp birthday;
  final String sex;
  final bool billing;
  final bool init;
  final Timestamp createdAt;
  final int activeDay;
  final String charactor;
  final String profession;

  UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.birthday,
    required this.sex,
    required this.billing,
    required this.init,
    required this.createdAt,
    required this.activeDay,
    required this.charactor,
    required this.profession,
  });

  UserData copy({
    String? id,
    String? name,
    String? email,
    Timestamp? birthday,
    String? sex,
    bool? billing,
    bool? init,
    Timestamp? createdAt,
    int? activeDay,
    String? charactor,
    String? profession,
  }) =>
      UserData(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        name: name ?? this.name,
        email: email ?? this.email,
        birthday: birthday ?? this.birthday,
        sex: sex ?? this.sex,
        billing: billing ?? this.billing,
        init: init ?? this.init,
        activeDay: activeDay ?? this.activeDay,
        charactor: charactor ?? this.charactor,
        profession: profession ?? this.profession,
      );

  static UserData fromJson(Map<String, Object?> json) => UserData(
        id: json[UserFields.id] as String,
        name: json[UserFields.name] as String,
        email: json[UserFields.email] as String,
        birthday: json[UserFields.createdAt] as Timestamp,
        sex: json[UserFields.sex] as String,
        billing: json[UserFields.billing] as bool,
        init: json[UserFields.init] as bool,
        createdAt: json[UserFields.createdAt] as Timestamp,
        activeDay: json[UserFields.activeDay] as int,
        charactor: json[UserFields.charactor] as String,
        profession: json[UserFields.profession] as String,
      );

  Map<String, Object?> toJson() => {
        UserFields.id: id,
        UserFields.name: name,
        UserFields.email: email,
        UserFields.birthday: birthday,
        UserFields.sex: sex,
        UserFields.billing: billing,
        UserFields.init: init,
        UserFields.createdAt: createdAt,
        UserFields.activeDay: activeDay,
        UserFields.charactor: charactor,
        UserFields.profession: profession,
      };

  static UserData fromEntity(UserEntity entity) => UserData(
        id: entity.id,
        name: entity.name,
        email: entity.email,
        birthday: Timestamp.fromDate(entity.birthday),
        sex: entity.sex.sexValue!,
        billing: entity.billing,
        init: entity.init,
        createdAt: Timestamp.fromDate(entity.createdAt),
        activeDay: entity.activeDay,
        charactor: entity.charactor.charactorValue!,
        profession: entity.profession,
      );

  UserEntity toEntity() => UserEntity(
        id: id,
        name: name,
        email: email,
        birthday: birthday.toDate(),
        sex: SexExtension.from(sex),
        billing: billing,
        init: init,
        createdAt: createdAt.toDate(),
        activeDay: activeDay,
        charactor: CharactorExtension.from(charactor),
        profession: profession,
      );
}
