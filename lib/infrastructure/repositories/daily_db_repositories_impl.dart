import 'package:aizuchi_app/domain/entity/enums/emotion.dart';
import 'package:aizuchi_app/domain/entity/models/daily.dart';
import 'package:aizuchi_app/domain/repositories/daily_db_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DailyDBRepositoryImpl implements DailyDBRepository {
  @override
  Future<List<DailyEntity>> read(DateTime startDate, DateTime endDate) async {
    final id = FirebaseAuth.instance.currentUser?.uid ?? '';
    try {
      final List<DailyEntity> dailies = [];
      await FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .collection('dailies')
          .where('createdAt', isGreaterThanOrEqualTo: startDate)
          .where('createdAt', isLessThanOrEqualTo: endDate)
          .orderBy('createdAt', descending: true)
          .get()
          .then((querySnapshot) {
        for (var doc in querySnapshot.docs) {
          final newDaily = DailyEntity(
            createdAt: doc['createdAt'].toDate(),
            emotion: EmotionTypeExtension.from(doc['emotion']),
            summary: doc['summary'],
          );
          dailies.add(newDaily);
        }
      });

      return dailies;
    } catch (e) {
      throw Exception('データの取得中にエラーが発生しました');
    }
  }

  @override
  Future<List<DailyEntity>> readAll() async {
    final id = FirebaseAuth.instance.currentUser?.uid ?? '';
    try {
      final List<DailyEntity> dailies = [];
      await FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .collection('dailies')
          .get()
          .then((querySnapshot) {
        for (var doc in querySnapshot.docs) {
          final newDaily = DailyEntity(
            createdAt: doc['createdAt'].toDate(),
            emotion: EmotionTypeExtension.from(doc['emotion']),
            summary: doc['summary'],
          );
          dailies.add(newDaily);
        }
      });
      return dailies;
    } catch (e) {
      throw Exception('データの取得中にエラーが発生しました');
    }
  }

  @override
  Future<void> updateLatest(DailyEntity daily) async {
    final String id = FirebaseAuth.instance.currentUser?.uid ?? '';

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .collection('dailies')
          .doc(_createId(daily.createdAt))
          .update({
        'createdAt': Timestamp.fromDate(daily.createdAt),
        'emotion': daily.emotion.emotionValue,
        'summary': daily.summary,
      });
    } catch (e) {
      throw Exception('データの取得中にエラーが発生しました');
    }
  }

  @override
  Future<void> create(DailyEntity daily) async {
    final id = FirebaseAuth.instance.currentUser?.uid ?? '';
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .collection('dailies')
          .doc(_createId(daily.createdAt))
          .set(
        {
          "createdAt": Timestamp.fromDate(daily.createdAt),
          "emotion": daily.emotion.emotionValue,
          "summary": daily.summary,
        },
      );
    } catch (e) {
      throw Exception('データの取得中にエラーが発生しました');
    }
  }

  String _createId(DateTime dateTime) {
    final DateTime now = DateTime.now();
    final String key = "${now.year}_${now.month}_${now.day}";
    return key;
  }

  @override
  Future<int> getDocumentCount() async {
    final id = FirebaseAuth.instance.currentUser?.uid ?? '';
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .collection("dailies")
          .orderBy("createdAt")
          .get();
      return querySnapshot.docs.length;
    } on FirebaseException catch (e) {
      // Firestoreからデータを取得する際にFirebaseExceptionが発生した場合の処理
      throw Exception('Firestoreからデータを取得できませんでした。$e');
    } catch (e) {
      // その他の例外が発生した場合の処理
      throw Exception('データの取得中に未知のエラーが発生しました。$e');
    }
  }
}
