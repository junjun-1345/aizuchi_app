import 'package:aizuchi_app/application/di/infrastructure.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firestore.g.dart';

@riverpod
Stream<Map<String, dynamic>> user(UserRef ref) {
  final db = FirebaseFirestore.instance;
  final id = FirebaseAuth.instance.currentUser?.uid ?? '';

  // データベースを監視
  final snapshots = db.collection("users").doc(id).snapshots();

  return snapshots.map((snapshot) => snapshot.data()!);
}

@riverpod
Stream<int> messageCountInt(MessageCountIntRef ref) {
  final db = FirebaseFirestore.instance;
  final id = FirebaseAuth.instance.currentUser?.uid ?? '';

  final snapshots =
      db.collection("users").doc(id).collection("messages").snapshots();
  return snapshots.map((snapshot) => snapshot.docs.length);
}

@riverpod
Stream<int> dailyCountInt(DailyCountIntRef ref) {
  final db = FirebaseFirestore.instance;
  final id = FirebaseAuth.instance.currentUser?.uid ?? '';

  final snapshots =
      db.collection("users").doc(id).collection("daily").snapshots();
  return snapshots.map((snapshot) => snapshot.docs.length);
}

@riverpod
Stream<String> dailyKeyStreamStr(DailyKeyStreamStrRef ref) {
  final db = FirebaseFirestore.instance;
  final id = FirebaseAuth.instance.currentUser?.uid ?? '';

  final snapshots = db
      .collection('users')
      .doc(id)
      .collection("daily")
      .orderBy("startAt", descending: true)
      .snapshots();

  return snapshots.map((snapshot) => snapshot.docs.first.id);
}
