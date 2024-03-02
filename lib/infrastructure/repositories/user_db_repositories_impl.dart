import 'package:aizuchi_app/domain/entity/models/user.dart';
import 'package:aizuchi_app/domain/repositories/user_db_repository.dart';
import 'package:aizuchi_app/infrastructure/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

class UserDBsRepositoryImpl implements UserDBRepository {
  @override
  Future<void> create(UserEntity form) async {
    final userData = UserData.fromEntity(form);
    try {
      userData.copy(
        id: FirebaseAuth.instance.currentUser?.uid,
        email: FirebaseAuth.instance.currentUser?.email,
      );
    } catch (e) {
      throw ("currentUser: エラー:$e");
    }

    final json = userData.toJson();

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .set(json);
    } catch (e) {
      throw ("userCreate: エラー:$e");
    }
  }

  @override
  Future<void> delete() {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<UserEntity> read() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();
      final map = doc.data();
      if (map == null) {
        return throw ("userRead エラー: mapのデータが空です");
      }
      final userData = UserData.fromJson(map);
      return userData.toEntity();
    } catch (e) {
      throw ("fetchUser エラー:$e");
    }
  }

  @override
  void update(UserEntity user) {
    final userData = UserData.fromEntity(user);
    final json = userData.toJson();

    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .update(json);
    } catch (e) {
      throw ("userCreate: エラー:$e");
    }
  }
}
