import 'package:aizuchi_app/domain/models/chatgptmessage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/models/appuser.dart';
import '../../../domain/models/message.dart';

abstract class FirestoreInterface {
  Future<void> userCreate(AppUser data);

  Future<AppUser> userRead();

  Future<void> userUpdate(AppUser data);

  Future<void> userDelete();

  Future<bool> userFind();

  Future<void> messageCreate(Message data);

  Future<List<ChatGPTMessage>> messageReadLimit(int num, String dailyKey);

  Future<List<ChatGPTMessage>> messageReadToday(Timestamp start, Timestamp end);

  Future<void> dailyCreate(String dailyKey);

  Future<Map<String, dynamic>> dailyRead(String key);

  Future<void> dailyUpdate(String key, value);

  Future<bool> dailyCheck(String key);

  Future<String> dailyGetKey();
}
