import 'package:aizuchi_app/domain/repositories/local_db_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDbRepositoriesImpl implements LocalDBRepository {
  @override
  Future<void> setIsSignUpTrue() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('is_sign_up', true);
  }

  @override
  Future<void> setIsSignUpFalse() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('is_sign_up', false);
  }
}
