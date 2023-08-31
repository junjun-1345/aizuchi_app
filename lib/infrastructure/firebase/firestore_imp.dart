import 'package:aizuchi_app/domain/models/appuser.dart';
import 'package:aizuchi_app/domain/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../application/interface/firebase/firestore.dart';

class FirestoreService implements FirestoreInterface {
  /// UserIDの取得
  final id = FirebaseAuth.instance.currentUser?.uid ?? '';

  // Cloud Firestore のインスタンスを初期化
  final db = FirebaseFirestore.instance;

  // user CRUD
  @override
  Future<void> userCreate(AppUser data) async {
    // JsonMap <--- データ
    final map = data.toJson();
    try {
      await db.collection('users').doc(id).set(map);
    } catch (e) {
      debugPrint("userCreate エラー。$e");
    }
  }

  // Read
  @override
  Future<AppUser> userRead() async {
    try {
      final doc = await db.collection('users').doc(id).get();
      final map = doc.data();
      if (map == null) {
        return throw ("userRead エラー。 mapのデータが空です");
      }
      return AppUser.fromJson(map);
    } catch (e) {
      return throw ("userRead エラー。$e");
    }
  }

  // Update
  @override
  Future<void> userUpdate(AppUser data) async {
    final map = data.toJson();
    try {
      await db.collection('users').doc(id).update(map);
    } catch (e) {
      debugPrint("userUpdate エラー。$e");
    }
  }

  // Delete
  @override
  Future<void> userDelete() async {
    try {
      await db.collection('users').doc(id).delete();
    } catch (e) {
      debugPrint("userDelete エラー。$e");
    }
  }

  // message CRUD
  @override
  Future<void> messageCreate(Message data) async {
    // JsonMap <--- データ
    final map = data.toJson();
    try {
      await db
          .collection('users')
          .doc(id)
          .collection("messages")
          .doc("${data.createdDate}${data.createdTime}}")
          .set(map);
    } catch (e) {
      debugPrint("userCreate エラー。$e");
    }
  }

  // Read Date
  @override
  Future<List<AppUser>> messageReadDate(String date) async {
    try {
      final List<AppUser> messages = [];
      final querySnapshot = await db
          .collection('users')
          .doc(id)
          .collection("messages")
          .where("createdDate", isEqualTo: date)
          .get();

      for (var doc in querySnapshot.docs) {
        messages.add(AppUser.fromJson(doc.data()));
      }
      return messages;
    } catch (e) {
      return throw ("userRead エラー。$e");
    }
  }

  // // Update
  // Future<void> messageUpdate(AppUser data) async {
  //   final map = data.toJson();
  //   try {
  //     await db.collection('users').doc(id).update(map);
  //   } catch (e) {
  //     debugPrint("userUpdate エラー。$e");
  //   }
  // }

  // // Delete
  // Future<void> messageDelete() async {
  //   try {
  //     await db.collection('users')
  //         .doc(id)
  //         .collection("messages")
  //   } catch (e) {
  //     debugPrint("userDelete エラー。$e");
  //   }
  // }
}
