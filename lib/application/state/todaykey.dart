import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todaykey.g.dart';

@Riverpod(keepAlive: true)
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

@Riverpod(keepAlive: true)
String dailyKeyChangeStr(DailyKeyChangeStrRef ref) {
  final dailyKey = ref.watch(dailyKeyStreamStrProvider);
  return dailyKey.when(
    loading: () => DateTime.now().toString(),
    error: (_, __) => DateTime.now().toString(),
    data: (d) => d,
  );
}

@Riverpod(keepAlive: true)
class TodaykeyNotifier extends _$TodaykeyNotifier {
  @override
  String build() {
    final dailyKeyChangeStr = ref.watch(dailyKeyChangeStrProvider);
    // 最初のデータ
    return dailyKeyChangeStr;
  }

  void changeState(String key) {
    state = key;
  }

  void initState() {
    final dailyKeyChangeStr = ref.watch(dailyKeyChangeStrProvider);
    state = dailyKeyChangeStr;
  }
}
