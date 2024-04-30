import 'package:aizuchi_app/domain/utils/datetime_utils.dart';
import 'package:aizuchi_app/presentation/model/daily_model.dart';
import 'package:aizuchi_app/presentation/view/pages/log/components/graph_contents/graph.dart';
import 'package:aizuchi_app/presentation/view/pages/log/components/select_date.dart';
import 'package:aizuchi_app/presentation/view_model/log_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WeeklyGraph extends HookConsumerWidget {
  const WeeklyGraph({
    required this.dailyList,
    Key? key,
  }) : super(key: key);

  final List<DailyModel> dailyList;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logViewModel = ref.read(logViewModelProvider);
    final now = DateTime.now();

    final startDateState = useState(now.mondayThisWeek);
    final endDateState = useState(now.sundayThisWeek);
    final isLatest = now.mondayThisWeek == startDateState.value;

    // 週間リストを取得する専用の関数
    List<DailyModel> getWeeklyList() {
      return logViewModel
          .filterDailiesByDateRange(
            dailyList,
            startDateState.value,
            endDateState.value,
          )
          .toList();
    }

    final List<DailyModel> weeklyList = getWeeklyList();
    return Column(
      children: [
        /// 棒グラフ
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.38,
          child: EmotionGraphLineChart(
            selectedMonthlyPage: false,
            dailyList: weeklyList,
          ),
        ),
        const SizedBox(height: 16),
        SelectDatePart(
          startDate: startDateState,
          endDate: endDateState,
          isMonthly: false,
          isLatest: isLatest,
        )
      ],
    );
  }
}
