import 'package:aizuchi_app/presentation/state/summary_state.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class LogPage extends HookConsumerWidget {
  const LogPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectDate = useState(DateTime(0));

    Future<void> get() async {
      ref
          .read(summaryNotifierProvider.notifier)
          .getWeeklySummary(selectDate.value);
    }

    return Center(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 160),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(1900, 1, 1),
                      maxTime: DateTime(2100, 1, 1), onConfirm: (date) {
                    selectDate.value = date;
                  }, currentTime: DateTime.now(), locale: LocaleType.jp);
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  selectDate.value == DateTime(0)
                      ? "指定日を入力"
                      : "${selectDate.value.year}年 ${selectDate.value.month}月 ${selectDate.value.day}日",
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                get();
              },
              child: const Text("検索"),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ref.watch(summaryNotifierProvider).when(
                    data: (dailies) => ListView.builder(
                      // reverse: true,
                      itemCount: dailies.length,
                      itemBuilder: (context, index) {
                        final daily = dailies[index];
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(daily.createdAt.toString()),
                                const SizedBox(width: 8),
                              ],
                            ),
                            Text(daily.content),
                          ],
                        );
                      },
                    ),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (error, _) =>
                        Center(child: Text('エラーが発生しました: $error')),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
