import 'package:aizuchi_app/presentation/state/daily_state.dart';
import 'package:aizuchi_app/presentation/state/user_state.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

final logViewModelProvider = Provider<LogViewModel>(
  (ref) => LogViewModel(
    ref,
    ref.read(usersNotifierProvider.notifier),
    ref.read(dailyNotifierProvider.notifier),
    DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1)),
  ),
);

class LogViewModel {
  final Ref ref;
  final UsersNotifier usersNotifier;
  final DailyNotifier dailyNotifier;
  DateTime _logStartDay;

  LogViewModel(
    this.ref,
    this.usersNotifier,
    this.dailyNotifier,
    DateTime logStartDay,
  ) : _logStartDay = logStartDay;

  // logStartDay の getter
  DateTime get logStartDay => _logStartDay;

  Future<void> changeToNextWeek() async {
    // 次の週の開始日を計算
    DateTime nextWeekStart = _logStartDay.add(const Duration(days: 7));

    // ログ開始日を更新
    _logStartDay = nextWeekStart;

    print("次の週の記録を取得しました");
  }

  Future<void> changeToPrevWeek() async {
    // 現在の週の開始日を取得
    DateTime startOfWeek = _logStartDay;

    // 前の週の開始日を計算
    DateTime prevWeekStart = startOfWeek.subtract(const Duration(days: 7));

    // ログ開始日を更新
    _logStartDay = prevWeekStart;

    print("前の週の記録を取得しました");
  }
}
