import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:aizuchi_app/presentation/model/daily_model.dart';
import 'package:aizuchi_app/presentation/view/pages/log/components/select_week.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DaysCarouselTile extends ConsumerWidget {
  const DaysCarouselTile({
    required this.dailyList,
    Key? key,
  }) : super(key: key);

  final List<DailyModel> dailyList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 曜日ごとのデータを格納するリスト
    final List<DailyModel?> weekDays = List.filled(7, null);

    // 曜日ごとにデータを挿入
    for (final summary in dailyList) {
      // 曜日のインデックスを取得
      final dayIndex = (summary.createdAt.weekday + 6) % 7;
      // データがすでにあるかどうかをチェックし、ない場合にのみデータを挿入
      if (weekDays[dayIndex] == null) {
        weekDays[dayIndex] = summary;
      }
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              for (final summary in weekDays)
                DailyTile(
                  day: _fetchDayOfWeek(weekDays.indexOf(summary)),
                  summary: summary?.summary ?? '',
                ),
              const SizedBox(height: 16),
              const SelectWeekPart(),
            ],
          ),
        ),
      ),
    );
  }
}

String _fetchDayOfWeek(int dayIndex) {
  switch (dayIndex) {
    case 0:
      return '月';
    case 1:
      return '火';
    case 2:
      return '水';
    case 3:
      return '木';
    case 4:
      return '金';
    case 5:
      return '土';
    case 6:
      return '日';
    default:
      return '';
  }
}

class DailyTile extends StatelessWidget {
  const DailyTile({
    required this.day,
    required this.summary,
    Key? key,
  }) : super(key: key);

  final String day;
  final String summary;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.06,
        decoration: BoxDecoration(
          color: BrandColor.base,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            Text(
              day,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                summary.isNotEmpty ? summary : '',
                style: const TextStyle(fontSize: 10),
                maxLines: 2,
              ),
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
