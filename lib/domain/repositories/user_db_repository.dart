import 'package:aizuchi_app/domain/entity/models/user.dart';

abstract class UserDBRepository {
  Future<void> create(UserEntity form);
  Future<UserEntity> read();
  Future<void> delete();
  void update(UserEntity form);
}
