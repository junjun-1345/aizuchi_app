import 'package:aizuchi_app/presentation/view_model/log_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class SelectWeekPart extends ConsumerWidget {
  const SelectWeekPart({
    required this.logStartDay,
    super.key,
  });

  final DateTime logStartDay;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String startDay = DateFormat('M/d').format(logStartDay);
    final String endDay =
        DateFormat('M/d').format(logStartDay.add(const Duration(days: 6)));
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            ref.read(logViewModelProvider).changeToPrevWeek();
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
          '$startDay 〜 $endDay',
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xffe79f95),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        GestureDetector(
          onTap: () {
            ref.read(logViewModelProvider).changeToNextWeek();
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
