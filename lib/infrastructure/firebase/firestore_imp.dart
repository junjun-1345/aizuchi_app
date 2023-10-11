import 'package:aizuchi_app/domain/features/datetime.dart';
import 'package:aizuchi_app/domain/models/chatgptmessage.dart';
import 'package:aizuchi_app/domain/models/message.dart';
import 'package:aizuchi_app/domain/models/appuser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../application/interface/firebase/firestore.dart';

class FirestoreService implements FirestoreInterface {
  final db = FirebaseFirestore.instance;

  ////////////////
  // user CRUD
  ////////////////
  @override
  Future<void> userCreate(AppUser data) async {
    final id = FirebaseAuth.instance.currentUser?.uid ?? '';

    // JsonMap <--- データ
    final map = data.toJson();
    try {
      print("ユーザーID$id");
      await db.collection('users').doc(id).set(map);
    } catch (e) {
      debugPrint("userCreate エラー:$e");
    }
  }

  @override
  Future<AppUser> userRead() async {
    final id = FirebaseAuth.instance.currentUser?.uid ?? '';

    try {
      final doc = await db.collection('users').doc(id).get();
      final map = doc.data();
      if (map == null) {
        return throw ("userRead エラー: mapのデータが空です");
      }
      return AppUser.fromJson(map);
    } catch (e) {
      return throw ("userRead エラー:$e");
    }
  }

  @override
  Future<void> userUpdate(AppUser data) async {
    final id = FirebaseAuth.instance.currentUser?.uid ?? '';

    final map = data.toJson();
    try {
      await db.collection('users').doc(id).update(map);
    } catch (e) {
      debugPrint("userUpdate エラー:$e");
    }
  }

  @override
  Future<void> userDelete() async {
    final id = FirebaseAuth.instance.currentUser?.uid ?? '';

    try {
      await db.collection('users').doc(id).delete();
    } catch (e) {
      debugPrint("userDelete エラー:$e");
    }
  }

  @override
  Future<bool> userFind() async {
    try {
      final id = FirebaseAuth.instance.currentUser?.uid ?? '';
      final data = await db.collection('users').doc(id).get();
      if (data.exists) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint("userFind エラー:$e");
    }
    return false;
  }

  ////////////////
  // message CRUD
  ////////////////

  @override
  Future<void> messageCreate(Message data) async {
    final id = FirebaseAuth.instance.currentUser?.uid ?? '';

    try {
      await db.collection('users').doc(id).collection("messages").doc().set(
        {
          "dailyKey": data.key,
          "createdAt": Timestamp.fromDate(data.createdAt),
          "role": data.role,
          "content": data.content,
        },
      );
    } catch (e) {
      debugPrint("messageCreate エラー:$e");
    }
  }

  @override
  Future<List<ChatGPTMessage>> messageReadLimit(
      int num, String dailyKey) async {
    final id = FirebaseAuth.instance.currentUser?.uid ?? '';
    try {
      final List<ChatGPTMessage> messages = [];
      await db
          .collection('users')
          .doc(id)
          .collection("messages")
          .where("dailyKey", isEqualTo: dailyKey)
          .where("role", whereIn: ["user", "system", "assistant"])
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
      return throw ("userRead エラー:$e");
    }
  }

  @override
  Future<List<ChatGPTMessage>> messageReadToday(
      Timestamp start, Timestamp end) async {
    final id = FirebaseAuth.instance.currentUser?.uid ?? '';
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
      return throw ("userRead エラー:$e");
    }
  }

  ////////////////
  // daily CRUD
  ////////////////

  @override
  Future<void> dailyCreate(String dailyKey) async {
    final id = FirebaseAuth.instance.currentUser?.uid ?? '';
    try {
      await db
          .collection('users')
          .doc(id)
          .collection("daily")
          .doc(dailyKey)
          .set(
        {
          "startAt": Timestamp.fromDate(DateTime.now()),
          "endAt": "",
          "title": "入力中です:",
          "emotion": "",
        },
      );
    } catch (e) {
      debugPrint("userCreate エラー:$e");
    }
  }

  @override
  Future<Map<String, dynamic>> dailyRead(String key) async {
    final id = FirebaseAuth.instance.currentUser?.uid ?? '';
    try {
      final documentSnapshot = await db
          .collection('users')
          .doc(id)
          .collection("daily")
          .doc(key)
          .get();

      return documentSnapshot.data() as Map<String, dynamic>;
    } catch (e) {
      return throw ("dailyRead エラー:$e");
    }
  }

  @override
  Future<void> dailyUpdate(String key, value) async {
    final id = FirebaseAuth.instance.currentUser?.uid ?? '';
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
      debugPrint("userCreate エラー:$e");
    }
  }

  @override
  Future<bool> dailyCheck(String key) async {
    final id = FirebaseAuth.instance.currentUser?.uid ?? '';
    try {
      final data = await db
          .collection('users')
          .doc(id)
          .collection("daily")
          .doc(key)
          .get();
      return data.exists;
    } catch (e) {
      debugPrint("userCreate エラー:$e");
      return false;
    }
  }

  @override
  Future<String> dailyGetKey() async {
    final id = FirebaseAuth.instance.currentUser?.uid ?? '';
    try {
      late String data;
      await db
          .collection('users')
          .doc(id)
          .collection("daily")
          .orderBy("startAt", descending: true)
          .limit(1)
          .get()
          .then(
            (querySnapshot) => querySnapshot.docs.forEach(
              (doc) => data = doc.id,
            ),
          );
      return data;
    } catch (e) {
      return throw ("dailyGetKey エラー:$e");
    }
  }
}