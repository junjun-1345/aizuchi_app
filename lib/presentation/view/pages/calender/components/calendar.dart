import 'package:aizuchi_app/domain/domain_module.dart';
import 'package:aizuchi_app/domain/entity/enums/day_of_week.dart';
import 'package:aizuchi_app/domain/entity/models/calendar.dart';
import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:aizuchi_app/domain/usecases/calendar_usecase.dart';
import 'package:aizuchi_app/presentation/model/daily_model.dart';
import 'package:aizuchi_app/presentation/state/daily_state.dart';
import 'package:aizuchi_app/presentation/view/components/app_loading.dart';
import 'package:aizuchi_app/presentation/view/pages/calender/components/calendar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Calendar extends ConsumerWidget {
  const Calendar({
    super.key,
    this.diffMonth = 0,
    this.isWeekStartMonday = false,
  });

  final int diffMonth;
  final bool isWeekStartMonday;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DateTime now = DateTime.now();
    final customDate = DateTime(now.year, now.month - diffMonth);
    final calendarUsecases = ref.read(calendarUsecaseProvider);
    final monthlyEmotions = ref.read(dailyNotifierProvider);
    return monthlyEmotions.when(
      data: (state) =>
          _buildCalendar(context, calendarUsecases, state, customDate),
      loading: () => const Center(
        child: AppLoading(),
      ),
      error: (error, _) => Center(child: Text('Error: $error')),
    );
  }

  Widget _buildCalendar(
    BuildContext context,
    CalendarUsecase calendarUsecases,
    List<DailyModel> state,
    DateTime customDate,
  ) {
    const double radiusSize = 16.0;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(radiusSize),
          bottom: Radius.circular(radiusSize),
        ),
      ),
      child: FutureBuilder(
        future: calendarUsecases.createCalendar(
          customDate.year,
          customDate.month,
          isWeekStartMonday,
          state.map((e) => e.toEntity()).toList(),
        ),
        builder: (context, snapshot) => _buildCalendarContent(
          context,
          snapshot,
          radiusSize,
        ),
      ),
    );
  }

  Widget _buildCalendarContent(
    BuildContext context,
    AsyncSnapshot<List<List<CalendarEntity>>> snapshot,
    double radiusSize,
  ) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(
        child: AppLoading(),
      );
    } else if (snapshot.hasError) {
      return Center(child: Text('Error: ${snapshot.error}'));
    } else if (snapshot.hasData) {
      return _calendarView(snapshot.data!, radiusSize);
    } else {
      return const Center(child: Text('No data available'));
    }
  }

  Widget _calendarView(List<List<CalendarEntity>> weeks, double radiusSize) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _weekdaysHeader(radiusSize),
        ...weeks.map((week) => _weekRow(week)).toList(),
      ],
    );
  }

  Widget _weekdaysHeader(double radiusSize) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radiusSize),
          topRight: Radius.circular(radiusSize),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: DayOfWeekExtension.getWeekDays(isWeekStartMonday)
            .map((day) => Expanded(
                  child: Center(
                    child: Text(day.name("jp"),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: BrandColor.baseRed)),
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _weekRow(List<CalendarEntity> week) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children:
          week.map((day) => Expanded(child: CalenderItem(data: day))).toList(),
    );
  }
}
