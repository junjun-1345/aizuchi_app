import 'package:aizuchi_app/domain/entity/enums/shared_preferences_key.dart';

abstract class SharedPreferencesRepository {
  Future<bool> save<T>(SharedPreferencesKey key, T value);
  Future<T?> fetch<T>(SharedPreferencesKey key);
  Future<bool> remove(SharedPreferencesKey key);
}
