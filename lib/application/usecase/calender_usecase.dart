import 'package:aizuchi_app/application/interface/firebase/firestore.dart';

class CalenderUsecase {
  CalenderUsecase({
    required this.firestore,
  });

  final FirestoreInterface firestore;

  Future<int> getSelectDayEmotion(String key) async {
    late int selectDayEmotionInt;

    final dailyFlag = await firestore.dailyCheck(key);
    if (dailyFlag) {
      final data = await firestore.dailyRead(key);
      selectDayEmotionInt = data["emotion"];
    }
    if (!dailyFlag) {
      selectDayEmotionInt = 5;
    }
    return selectDayEmotionInt;
  }
}
