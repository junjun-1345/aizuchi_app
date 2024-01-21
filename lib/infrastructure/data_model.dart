import 'package:aizuchi_app/domain/repositories/auth_repository.dart';
import 'package:aizuchi_app/domain/repositories/local_db_repository.dart';
import 'package:aizuchi_app/domain/repositories/user_db_repository.dart';
import 'package:aizuchi_app/infrastructure/repositories/auth_repositories_impl.dart';
import 'package:aizuchi_app/infrastructure/repositories/local_db_repositories_impl.dart';
import 'package:aizuchi_app/infrastructure/repositories/user_db_repositories_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl();
});

final userDBRepositoryProvider = Provider<UserDBRepository>((ref) {
  return UserDBsRepositoryImpl();
});

final localDBRepositoryProvider = Provider<LocalDBRepository>((ref) {
  return LocalDbRepositoriesImpl();
});
