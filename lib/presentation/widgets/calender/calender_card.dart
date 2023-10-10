// カードの中身
import 'package:aizuchi_app/application/di/usecase.dart';
import 'package:aizuchi_app/application/state/dailykey_state.dart';
import 'package:aizuchi_app/domain/features/datetime.dart';
import 'package:aizuchi_app/domain/models/emotion_model.dart';
import 'package:aizuchi_app/domain/models/weekday_model.dart';
import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:aizuchi_app/presentation/theme/colors.dart';
import 'package:aizuchi_app/presentation/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomCalender extends ConsumerWidget {
  final int diff;
  const CustomCalender(this.diff, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = DateTime.now();
    final List<List<DateTime?>> selectedMonthInDaysList =
        CustomDateTime().selectedMonthInDaysDat(now.year, now.month - diff, 7);

    final calenderUsecase = ref.read(calenderUsecaseProvider);
    final dailyKeyNotifier = ref.read(dailykeyStateNotifierProvider.notifier);

    //週ごとのリストROWを作成
    List<TableRow> _selectedMonthInWeekTableRows() {
      return selectedMonthInDaysList.map(
        (row) {
          return TableRow(
            children: row.map((cell) {
              if (cell == null) {
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(""),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(""),
                    ),
                  ],
                );
              } else {
                return Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      cell.day.toString(),
                      style: BrandText.textCalender
                          .copyWith(color: BrandColor.baseRed),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: FutureBuilder<Object>(
                        // 指定日のemotionを取得
                        future: calenderUsecase
                            .getSelectDayEmotion(cell.toString()),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text(
                              "error",
                              style: BrandText.emojiCalender,
                            );
                          } else if (snapshot.hasData) {
                            if (int.parse(snapshot.data.toString()) < 5) {
                              return TextButton(
                                onPressed: () {
                                  dailyKeyNotifier.setState(cell.toString());
                                  context.go(PagePath.selectChat);
                                },
                                child: Text(
                                    Emotion
                                        .values[
                                            int.parse(snapshot.data.toString())]
                                        .name,
                                    style: BrandText.emojiCalender),
                              );
                            } else {
                              return Text(
                                "🫥",
                                style: BrandText.emojiCalender,
                              );
                            }
                          } else {
                            return const CircularProgressIndicator();
                          }
                        }),
                  ),
                ]);
              }
            }).toList(),
          );
        },
      ).toList();
    }

    // 曜日のROW
    TableRow _weekDayRow() {
      List<Widget> weekDays = [];
      for (int i = 7; i < 14; i++) {
        final weekDayInt = i % 7;
        weekDays.add(
          Container(
            padding: EdgeInsets.all(8.0),
            child: Text(
              Weekday.values[weekDayInt].name,
              textAlign: TextAlign.center,
              style: BrandText.textCalender.copyWith(color: BrandColor.baseRed),
            ),
          ),
        );
      }
      return TableRow(children: weekDays);
    }

    final _selectedMonthInWeekTableRowsList = _selectedMonthInWeekTableRows();
    _selectedMonthInWeekTableRowsList.insert(0, _weekDayRow());

    /// レイアウト
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Table(
            children: _selectedMonthInWeekTableRowsList,
          ),
        ],
      ),
    );
  }
}
