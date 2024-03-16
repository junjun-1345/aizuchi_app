import 'package:aizuchi_app/presentation/state/summary_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class SelectWeekPart extends HookConsumerWidget {
class SelectWeekPart extends HookConsumerWidget {
  const SelectWeekPart({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logEndDate = useState(
      DateTime.now().subtract(Duration(days: DateTime.now().weekday - 7)),
    );
    final logStartDate = useState(
      DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1)),
    );

    final DateTime endDay = DateTime(
        logEndDate.value.year, logEndDate.value.month, logEndDate.value.day);
    final DateTime today =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            logEndDate.value =
                logEndDate.value.subtract(const Duration(days: 7));
            logStartDate.value =
                logStartDate.value.subtract(const Duration(days: 7));
            ref
                .read(summaryNotifierProvider.notifier)
                .getWeeklySummary(logEndDate.value);
          },
          child: Container(
            height: 25,
            width: 25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                width: 1,
                color: const Color(0xffe79f95),
              ),
            ),
            child: const Icon(
              Icons.navigate_before,
              color: Color(0xffe79f95),
            ),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          '${logStartDate.value.month}/${logStartDate.value.day}(${DateFormat.EEEE('ja').format(logStartDate.value)[0]})〜${logEndDate.value.month}/${logEndDate.value.day}(${DateFormat.EEEE('ja').format(logEndDate.value)[0]})',
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xffe79f95),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        if (endDay.isBefore(today))
          GestureDetector(
            onTap: () {
              logEndDate.value = logEndDate.value.add(const Duration(days: 7));
              logStartDate.value =
                  logStartDate.value.add(const Duration(days: 7));
              ref
                  .read(summaryNotifierProvider.notifier)
                  .getWeeklySummary(logEndDate.value);
            },
            child: Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  width: 1,
                  color: const Color(0xffe79f95),
                ),
              ),
              child: const Icon(
                Icons.navigate_next,
                color: Color(0xffe79f95),
              ),
            ),
          ),
      ],
    );
  }
}
