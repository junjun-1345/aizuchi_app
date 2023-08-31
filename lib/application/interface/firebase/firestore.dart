import '../../../domain/models/appuser.dart';
import '../../../domain/models/message.dart';

abstract class FirestoreInterface {
  Future<void> userCreate(AppUser data);

  Future<AppUser> userRead();

  Future<void> userUpdate(AppUser data);

  Future<void> userDelete();

  Future<void> messageCreate(Message data);

  Future<List<AppUser>> messageReadDate(String date);
}
