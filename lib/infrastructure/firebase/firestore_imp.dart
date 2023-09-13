import 'package:aizuchi_app/domain/features/datetime.dart';
import 'package:aizuchi_app/domain/models/chatgptmessage.dart';
import 'package:aizuchi_app/domain/models/message.dart';
import 'package:aizuchi_app/domain/models/appuser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../application/interface/firebase/firestore.dart';

class FirestoreService implements FirestoreInterface {
  /// UserIDの取得
  final id = FirebaseAuth.instance.currentUser?.uid ?? '';

  // Cloud Firestore のインスタンスを初期化
  final db = FirebaseFirestore.instance;

  ////////////////
  // user CRUD
  ////////////////

  // Create
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
    debugPrint(id);
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

  ////////////////
  // message CRUD
  ////////////////

  // Create
  @override
  Future<void> messageCreate(Message data) async {
    try {
      await db.collection('users').doc(id).collection("messages").doc().set(
        {
          "createdAt": Timestamp.fromDate(data.createdAt),
          "role": data.role,
          "content": data.content,
        },
      );
    } catch (e) {
      debugPrint("userCreate エラー。$e");
    }
  }

  // Read
  @override
  Future<List<ChatGPTMessage>> messageReadLimit(int num) async {
    try {
      final List<ChatGPTMessage> messages = [];
      await db
          .collection('users')
          .doc(id)
          .collection("messages")
          .orderBy("createdAt")
          .limit(num)
          .get()
          .then((querySnapshot) {
        for (var doc in querySnapshot.docs) {
          final newMessage = ChatGPTMessage(
            role: doc["role"],
            content: doc["content"],
          );
          messages.add(newMessage);
        }
      });

      return messages;
    } catch (e) {
      return throw ("userRead エラー。$e");
    }
  }

  // Read
  @override
  Future<List<ChatGPTMessage>> messageReadToday(
      Timestamp start, Timestamp end) async {
    try {
      final List<ChatGPTMessage> messages = [];
      await db
          .collection('users')
          .doc(id)
          .collection("messages")
          .orderBy("createdAt")
          .startAt([start])
          .endAt([end])
          .get()
          .then((querySnapshot) {
            for (var doc in querySnapshot.docs) {
              final newMessage = ChatGPTMessage(
                role: doc["role"],
                content: doc["content"],
              );
              messages.add(newMessage);
            }
          });

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

  ////////////////
  // daily CRUD
  ////////////////

  // Create
  @override
  Future<void> dailyCreate() async {
    try {
      await db
          .collection('users')
          .doc(id)
          .collection("daily")
          .doc(CustomDateTime().nowDate())
          .set(
        {
          "startAt": Timestamp.fromDate(DateTime.now()),
          "endAt": "",
          "title": "",
          "emotion": "",
        },
      );
    } catch (e) {
      debugPrint("userCreate エラー。$e");
    }
  }

  // Reed
  @override
  Future<Map<String, dynamic>> dailyRead(String key) async {
    final snapShot =
        await db.collection('users').doc(id).collection("daily").doc(key).get();
    final data = snapShot.data() as Map<String, dynamic>;
    print(data);
    return data;
  }

  // Update
  @override
  Future<void> dailyUpdate(String key, value) async {
    try {
      await db
          .collection('users')
          .doc(id)
          .collection("daily")
          .doc(CustomDateTime().nowDate())
          .update(
        {
          key: value,
        },
      );
    } catch (e) {
      debugPrint("userCreate エラー。$e");
    }
  }

  // check
  @override
  Future<bool> dailyCheck(String key, String word) async {
    try {
      final data = await db
          .collection('users')
          .doc(id)
          .collection("daily")
          .doc(CustomDateTime().nowDate())
          .get();
      return data.exists;
    } catch (e) {
      debugPrint("userCreate エラー。$e");
      return false;
    }
  }
}
