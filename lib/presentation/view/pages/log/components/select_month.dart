import 'package:aizuchi_app/presentation/state/daily_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class SelectMonthPart extends HookConsumerWidget {
  const SelectMonthPart({
    required this.logStartDate,
    required this.logEndDate,
    super.key,
  });

  final ValueNotifier<DateTime> logStartDate;
  final ValueNotifier<DateTime> logEndDate;

  bool get lastMonth => logEndDate.value.month == DateTime.now().month;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            logStartDate.value = DateTime(
                logStartDate.value.year, logStartDate.value.month - 1, 1);
            logEndDate.value =
                DateTime(logEndDate.value.year, logEndDate.value.month, 1)
                    .subtract(const Duration(days: 1));
            ref
                .read(dailyNotifierProvider.notifier)
                .addMonthlyDaily(logEndDate.value);
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
        if (!lastMonth)
          GestureDetector(
            onTap: () {
              logStartDate.value = DateTime(
                  logStartDate.value.year, logStartDate.value.month + 1, 1);
              logEndDate.value =
                  DateTime(logEndDate.value.year, logEndDate.value.month + 2, 1)
                      .subtract(const Duration(days: 1));
              ref
                  .read(dailyNotifierProvider.notifier)
                  .addMonthlyDaily(logEndDate.value);
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
