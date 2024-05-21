import 'package:aizuchi_app/domain/utils/datetime_utils.dart';
import 'package:aizuchi_app/presentation/state/app_state.dart';
import 'package:aizuchi_app/presentation/view_model/log_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class SelectDatePart extends HookConsumerWidget {
  const SelectDatePart({
    required this.startDate,
    required this.endDate,
    required this.isMonthly,
    required this.isLatest,
    super.key,
  });

  final ValueNotifier<DateTime> startDate;
  final ValueNotifier<DateTime> endDate;
  final bool isMonthly;
  final bool isLatest;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logViewModel = ref.read(logViewModelProvider);
    final oldestUpdateDate = ref.watch(oldestUpdateDateProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            if (isMonthly) {
              startDate.value = startDate.value.subtractMonths(1);
              endDate.value = endDate.value.subtractMonths(1);
            } else {
              startDate.value = startDate.value.subtractWeeks(1);
              endDate.value = endDate.value.subtractWeeks(1);
            }
            logViewModel.addDailyState(
                endDate.value, startDate.value, oldestUpdateDate);
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
          '${startDate.value.month}/${startDate.value.day}(${DateFormat.EEEE('ja').format(startDate.value)[0]})〜${endDate.value.month}/${endDate.value.day}(${DateFormat.EEEE('ja').format(endDate.value)[0]})',
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xffe79f95),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        if (!isLatest)
          GestureDetector(
            onTap: () {
              if (isMonthly) {
                startDate.value = startDate.value.addMonths(1);
                endDate.value = endDate.value.addMonths(1);
              } else {
                startDate.value = startDate.value.addWeeks(1);
                endDate.value = endDate.value.addWeeks(1);
              }
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

  DateTime addWeeks(DateTime dateTime, int weeks) {
    return dateTime.add(Duration(days: 7 * weeks));
  }

  DateTime subtractWeeks(DateTime dateTime, int weeks) {
    return dateTime.subtract(Duration(days: 7 * weeks));
  }

  DateTime addMonths(DateTime dateTime, int months) {
    return DateTime(
        dateTime.year + (dateTime.month + months - 1) ~/ 12,
        (dateTime.month + months - 1) % 12 + 1,
        dateTime.day,
        dateTime.hour,
        dateTime.minute,
        dateTime.second,
        dateTime.millisecond,
        dateTime.microsecond);
  }

  DateTime subtractMonths(DateTime dateTime, int months) {
    return addMonths(dateTime, -months);
  }
}
