import 'package:aizuchi_app/domain/utils/datetime_utils.dart';
import 'package:aizuchi_app/presentation/model/daily_model.dart';
import 'package:aizuchi_app/presentation/view/pages/log/components/graph_contents/graph.dart';
import 'package:aizuchi_app/presentation/view/pages/log/components/select_date.dart';
import 'package:aizuchi_app/presentation/view_model/log_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MonthlyGraph extends HookConsumerWidget {
  const MonthlyGraph({
    required this.dailyList,
    Key? key,
  }) : super(key: key);

  final List<DailyModel> dailyList;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logViewModel = ref.read(logViewModelProvider);
    final now = DateTime.now();

    final startDateState = useState(now.firstDayOfMonth);
    final endDateState = useState(now.lastDayOfMonth);
    final isLatest = now.firstDayOfMonth == startDateState.value;

    List<DailyModel> getMonthlyList() {
      return logViewModel
          .filterDailiesByDateRange(
            dailyList,
            startDateState.value,
            endDateState.value,
          )
          .toList();
    }

    final List<DailyModel> monthlyList = getMonthlyList();

    return Column(
      children: [
        /// 棒グラフ
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.38,
          child: EmotionGraphLineChart(
            dailyList: monthlyList,
            selectedMonthlyPage: true,
          ),
        ),
        const SizedBox(height: 16),
        SelectDatePart(
          startDate: startDateState,
          endDate: endDateState,
          isMonthly: true,
          isLatest: isLatest,
        )
      ],
    );
  }
}
