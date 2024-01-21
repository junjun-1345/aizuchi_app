import 'package:aizuchi_app/domain/entity/model/user.dart';

abstract class UserDBRepository {
  Future<void> create(UserEntity form);
  Future<UserEntity> read();
  Future<void> delete();
  Future<void> update(UserEntity form);
}
