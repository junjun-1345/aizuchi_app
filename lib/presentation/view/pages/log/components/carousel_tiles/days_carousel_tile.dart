import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:aizuchi_app/presentation/model/daily_model.dart';
import 'package:aizuchi_app/presentation/view/pages/log/components/select_week.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DaysCarouselTile extends StatelessWidget {
  const DaysCarouselTile({
    required this.dailyList,
    required this.logStartDay,
  }) : super(key: key);
  final DateTime logStartDay;

  @override
  Widget build(BuildContext context) {
    final DateTime endDay = logStartDay.add(const Duration(days: 6));
    final List<DailyModel> weekLogs = dailyList
        .where(
          (element) =>
              element.createdAt
                  .isAfter(logStartDay.add(const Duration(days: -1))) &&
              element.createdAt.isBefore(endDay),
        )
        .toList();

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
              const SizedBox(
                height: 16,
              ),
              for (DailyModel weekLog in weekLogs)
                DailyTyle(
                  day: DateFormat.EEEE('ja').format(weekLog.createdAt)[0],
                  summary: weekLog.summary,
                ),
              const SizedBox(
                height: 16,
              ),
              SelectWeekPart(
                logStartDay: logStartDay,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DailyTyle extends StatelessWidget {
  const DailyTyle({
    required this.day,
    this.summary,
    Key? key,
  }) : super(key: key);

  final String day;
  final String? summary;

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
            const SizedBox(
              width: 16,
            ),
            Text(
              day,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Text(
                summary ?? '',
                style: const TextStyle(fontSize: 10),
                maxLines: 2,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
          ],
        ),
      ),
    );
  }
}
