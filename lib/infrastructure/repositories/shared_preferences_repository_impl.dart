import 'package:aizuchi_app/domain/repositories/shared_preferences_repository.dart';
import 'package:aizuchi_app/infrastructure/enums/shared_preferences_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesRepositorImpl implements SharedPreferencesRepository {
  @override
  Future<T?> fetch<T>(SharedPreferencesKey key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (T.toString() == 'int') {
      return prefs.getInt(key.name) as T?;
    }
    if (T.toString() == 'double') {
      return prefs.getDouble(key.name) as T?;
    }
    if (T.toString() == 'bool') {
      return prefs.getBool(key.name) as T?;
    }
    if (T.toString() == 'String') {
      return prefs.getString(key.name) as T?;
    }
    if (T.toString() == 'List<String>') {
      return prefs.getStringList(key.name) as T?;
    }
    return null;
  }

  @override
  Future<bool> save<T>(SharedPreferencesKey key, T value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value is int) {
      return prefs.setInt(key.name, value);
    }
    if (value is double) {
      return prefs.setDouble(key.name, value);
    }
    if (value is bool) {
      return prefs.setBool(key.name, value);
    }
    if (value is String) {
      return prefs.setString(key.name, value);
    }
    if (value is List<String>) {
      return prefs.setStringList(key.name, value);
    }
    return false;
  }

  @override
  Future<bool> remove(SharedPreferencesKey key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(key.name);
  }
}
