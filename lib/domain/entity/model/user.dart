import 'package:aizuchi_app/domain/entity/enum/character.dart';
import 'package:aizuchi_app/domain/entity/enum/sex.dart';

class UserEntity {
  final String id;
  final String name;
  final String email;
  final DateTime birthday;
  final SexEnum sex;
  final bool billing;
  final bool init;
  final DateTime createdAt;
  final int activeDay;
  final CharactorEnum charactor;
  final String profession;

  UserEntity({
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
}
