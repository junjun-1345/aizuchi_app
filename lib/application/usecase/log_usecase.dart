import 'package:aizuchi_app/application/interface/firebase/firestore.dart';
import 'package:aizuchi_app/domain/features/datetime.dart';

class LogUsecase {
  LogUsecase({
    required this.firestore,
  });

  final FirestoreInterface firestore;

  Future<List<dynamic>> getThisWeekTitles() async {
    final _weekDateTitleList = [];
    final _weekDatesList = CustomDateTime().thisWeekDatesStr();
    for (int i = 0; i < 7; i++) {
      final dailyBool = await firestore.dailyCheck(_weekDatesList[i]);
      if (dailyBool) {
        final data = await firestore.dailyRead(_weekDatesList[i]);
        _weekDateTitleList.add(data["title"]);
      }
      if (!dailyBool) {
        _weekDateTitleList.add("データがありません。");
      }
    }
    return _weekDateTitleList;
  }

  Future<List<dynamic>> getThisWeekEmotions() async {
    final _weekDateEmotionList = [];
    final _weekDatesList = CustomDateTime().thisWeekDatesStr();
    for (int i = 0; i < 7; i++) {
      final dailyBool = await firestore.dailyCheck(_weekDatesList[i]);
      if (dailyBool) {
        final data = await firestore.dailyRead(_weekDatesList[i]);
        _weekDateEmotionList.add(data["emotion"]);
      }
      if (!dailyBool) {
        _weekDateEmotionList.add(0);
      }
    }
    return _weekDateEmotionList;
  }

  Future<List<dynamic>> getThisMonthEmotions() async {
    final _monthDateEmotionList = [];
    final _monthDatesList = CustomDateTime().thisMonthDatesStr();

    for (int i = 0; i < CustomDateTime().lastDayInMonth(); i++) {
      final dailyBool = await firestore.dailyCheck(_monthDatesList[i]);
      if (dailyBool) {
        final data = await firestore.dailyRead(_monthDatesList[i]);
        _monthDateEmotionList.add(data["emotion"]);
      }
      if (!dailyBool) {
        _monthDateEmotionList.add(0);
      }
    }
    return _monthDateEmotionList;
  }
}
