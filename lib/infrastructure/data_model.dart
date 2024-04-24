import 'package:aizuchi_app/domain/repositories/auth_repository.dart';
import 'package:aizuchi_app/domain/repositories/daily_db_repository.dart';
import 'package:aizuchi_app/domain/repositories/gpt_repository.dart';
import 'package:aizuchi_app/domain/repositories/message_db_repository.dart';
import 'package:aizuchi_app/domain/repositories/gemini_repository.dart';
import 'package:aizuchi_app/domain/repositories/local_db_repository.dart';
import 'package:aizuchi_app/domain/repositories/purchases_flutter_repository.dart';
import 'package:aizuchi_app/domain/repositories/remote_config.dart';
import 'package:aizuchi_app/domain/repositories/shared_preferences_repository.dart';
import 'package:aizuchi_app/domain/repositories/user_db_repository.dart';
import 'package:aizuchi_app/infrastructure/repositories/auth_repositories_impl.dart';
import 'package:aizuchi_app/infrastructure/repositories/daily_db_repositories_impl.dart';
import 'package:aizuchi_app/infrastructure/repositories/gpt_repository_impl.dart';
import 'package:aizuchi_app/infrastructure/repositories/message_db_repositories_impl.dart';
import 'package:aizuchi_app/infrastructure/repositories/gemini_repository_impl.dart';
import 'package:aizuchi_app/infrastructure/repositories/local_db_repositories_impl.dart';
import 'package:aizuchi_app/infrastructure/repositories/purchases_flutter_repository_impl.dart';
import 'package:aizuchi_app/infrastructure/repositories/remote_config_repository_impl.dart';
import 'package:aizuchi_app/infrastructure/repositories/shared_preferences_repository_impl.dart';
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

final messageDBRepositoryProvider = Provider<MessageDBRepository>((ref) {
  return MessageDBRepositoryImpl();
});

final geminiRepositoryProvider = Provider<GeminiRepository>((ref) {
  return GenimiRepositoryImpl();
});

final gptRepositoryProvider = Provider<GptRepository>((ref) {
  return GptRepositoryImpl();
});

final dailyDBRepositoryProvider = Provider<DailyDBRepository>((ref) {
  return DailyDBRepositoryImpl();
});

final purchasesFlutterProvider = Provider<PurchasesFlutterRepository>((ref) {
  return PurchasesFlutterRepositoryImpl();
});

final sharedPreferencesProvider = Provider<SharedPreferencesRepository>((ref) {
  return SharedPreferencesRepositorImpl();
});

final remoteConfigProvider = Provider<RemoteConfigRepository>((ref) {
  return RemoteConfigRepositoryImpl();
});
