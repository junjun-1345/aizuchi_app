import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:aizuchi_app/presentation/model/daily_model.dart';
import 'package:aizuchi_app/presentation/view/pages/log/components/graph_contents/monthly_graph.dart';
import 'package:aizuchi_app/presentation/view/pages/log/components/graph_contents/weekly_graph.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EmotionGraphTile extends HookConsumerWidget {
  const EmotionGraphTile({
    required this.dailyList,
    Key? key,
  }) : super(key: key);

  final List<DailyModel> dailyList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const double width = 240.0;
    const double height = 30.0;
    const double loginAlign = -1;
    const double signInAlign = 1;
    const Color selectedColor = Colors.white;
    const Color normalColor = Colors.black54;

    final xAlign = useState(loginAlign);
    final loginColor = useState(selectedColor);
    final signInColor = useState(normalColor);
    final selectedMonthlyPage = useState(false);

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
                  height: 8,
                ),
                const Text(
                  '感情グラフ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),

                const SizedBox(
                  height: 12,
                ),
                Container(
                  width: width,
                  height: height,
                  decoration: const BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.all(
                      Radius.circular(50.0),
                    ),
                  ),
                  child: Stack(
                    children: [
                      AnimatedAlign(
                        alignment: Alignment(xAlign.value, 0),
                        duration: const Duration(milliseconds: 300),
                        child: Container(
                          width: width * 0.5,
                          height: height,
                          decoration: const BoxDecoration(
                            color: BrandColor.baseRed,
                            borderRadius: BorderRadius.all(
                              Radius.circular(50.0),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          selectedMonthlyPage.value = false;
                          xAlign.value = loginAlign;
                          loginColor.value = selectedColor;
                          signInColor.value = normalColor;
                        },
                        child: Align(
                          alignment: const Alignment(-1, 0),
                          child: Container(
                            width: width * 0.5,
                            color: Colors.transparent,
                            alignment: Alignment.center,
                            child: Text(
                              'weekly',
                              style: TextStyle(
                                color: loginColor.value,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          selectedMonthlyPage.value = true;
                          xAlign.value = signInAlign;
                          signInColor.value = selectedColor;
                          loginColor.value = normalColor;
                        },
                        child: Align(
                          alignment: const Alignment(1, 0),
                          child: Container(
                            width: width * 0.5,
                            color: Colors.transparent,
                            alignment: Alignment.center,
                            child: Text(
                              'monthly',
                              style: TextStyle(
                                color: signInColor.value,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                /// 棒グラフ
                selectedMonthlyPage.value
                    ? MonthlyGraph(dailyList: dailyList)
                    : WeeklyGraph(dailyList: dailyList),
              ],
            ),
          ),
        ));
  }
}
