import 'package:aizuchi_app/domain/entity/enums/character.dart';
import 'package:aizuchi_app/domain/entity/enums/sex.dart';
import 'package:aizuchi_app/domain/entity/models/user.dart';
import 'package:aizuchi_app/domain/repositories/user_db_repository.dart';
import 'package:aizuchi_app/infrastructure/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDBsRepositoryImpl implements UserDBRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<void> create(UserEntity form) async {
    try {
      final uid = _auth.currentUser?.uid;
      final email = _auth.currentUser?.email;
      if (uid == null) throw Exception("currentUser: ユーザーIDがnullです。");
      final userData =
          UserData.fromEntity(form).copyWith(id: uid, email: email);
      final json = userData.toJson();
      await _firestore.collection('users').doc(uid).set(json);
    } catch (e) {
      throw Exception("userCreate: エラー:$e");
    }
  }

  @override
  Future<void> delete() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception("currentUser: ユーザーIDがnullです。");
    await _firestore.collection('users').doc(uid).delete();
  }

  @override
  Future<UserEntity> read() async {
    try {
      final uid = _auth.currentUser?.uid;
      if (uid == null) throw Exception("currentUser: ユーザーIDがnullです。");
      final doc = await _firestore.collection('users').doc(uid).get();
      final map = doc.data();
      if (map == null) throw Exception("userRead エラー: ユーザーデータが見つかりません。");
      return UserData.fromJson(map).toEntity();
    } catch (e) {
      throw Exception("fetchUser エラー:$e");
    }
  }


  @override

  Future<UserEntity> update({
    String? id,
    String? name,
    String? email,
    DateTime? birthday,
    SexEnum? sex,

    bool? isSubscription,

    bool? init,
    DateTime? createdAt,
    int? activeDay,
    CharactorEnum? charactor,
    String? profession,
    String? dailyKey,
    bool? isConversation,
    bool? isAssistant,
    bool? isMessageOverLimit,
    int? totalMessages,
  }) async {
    try {
      final uid = _auth.currentUser?.uid;
      if (uid == null) throw Exception("currentUser: ユーザーIDがnullです。");
      final user = await read();
      final updateData = user.copyWith(
        id: id ?? user.id,
        name: name ?? user.name,
        email: email ?? user.email,
        birthday: birthday ?? user.birthday,
        sex: sex ?? user.sex,

        isSubscription: isSubscription ?? user.isSubscription,

        init: init ?? user.init,
        createdAt: createdAt ?? user.createdAt,
        activeDay: activeDay ?? user.activeDay,
        charactor: charactor ?? user.charactor,
        profession: profession ?? user.profession,
        dailyKey: dailyKey ?? user.dailyKey,
        isConversation: isConversation ?? user.isConversation,
        isAssistant: isAssistant ?? user.isAssistant,
        isMessageOverLimit: isMessageOverLimit ?? user.isMessageOverLimit,
        totalMessages: totalMessages ?? user.totalMessages,
      );

      final updateJson = UserData.fromEntity(updateData).toJson();
      await _firestore.collection('users').doc(uid).update(updateJson);

      return updateData;
    } catch (e) {
      throw Exception("Failed to update user: $e");
    }
  }
}
