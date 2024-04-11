import 'dart:math';

import 'package:aizuchi_app/domain/entity/enums/emotion.dart';
import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:aizuchi_app/presentation/model/daily_model.dart';
import 'package:aizuchi_app/presentation/view/pages/log/components/select_month.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EmotionStockTile extends HookConsumerWidget {
  const EmotionStockTile({
    required this.dailyList,
    Key? key,
  }) : super(key: key);

  final List<DailyModel> dailyList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logStartDate =
        useState(DateTime(DateTime.now().year, DateTime.now().month, 1));
    final logEndDate = useState(
        DateTime(DateTime.now().year, DateTime.now().month + 1, 1)
            .subtract(const Duration(days: 1)));

    final Map<EmotionType, double> emotionCounts = {
      for (var type in EmotionType.values) type: 0,
    };

    for (var dailyModel in dailyList) {
      // 感情ごとにカウントを増やす
      if (emotionCounts.containsKey(dailyModel.emotion)) {
        emotionCounts[dailyModel.emotion] =
            emotionCounts[dailyModel.emotion]! + 1;
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
                const Text(
                  '感情ストック',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  width: 100,
                  height: 24,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: BrandColor.baseRed),
                  child: Center(
                    child: Text(
                      '${logStartDate.value.month}月',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                /// 棒グラフ
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.38,
                  child: EmotionStockBarChart(emotionCounts: emotionCounts),
                ),
                const SizedBox(height: 16),

                SelectMonthPart(
                  logStartDate: logStartDate,
                  logEndDate: logEndDate,
                ),
              ],
            ),
          ),
        ));
  }
}

class EmotionStockBarChart extends StatelessWidget {
  const EmotionStockBarChart({
    super.key,
    required this.emotionCounts,
  });

  final Map<EmotionType, double> emotionCounts;

  @override
  Widget build(BuildContext context) {
    final List<double> emotionAmounts = emotionCounts.values.toList();
    final List<String?> emotions =
        emotionCounts.keys.map((emotion) => emotion.emotionValue).toList();

    return BarChart(
      BarChartData(
        maxY: emotionAmounts.reduce(max),
        backgroundColor: BrandColor.base,
        borderData: FlBorderData(
          border: const Border(
            top: BorderSide.none,
            right: BorderSide.none,
            left: BorderSide.none,
            bottom: BorderSide.none,
          ),
        ),
        titlesData: FlTitlesData(
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
                sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) => Text(
                emotions[value.toInt()]!,
                style: const TextStyle(fontSize: 18),
              ),
            ))),
        groupsSpace: 12,
        gridData: const FlGridData(show: false),
        barGroups: [
          ...List.generate(
            5,
            (index) => BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: emotionAmounts[index].toDouble(),
                  width: 20,
                  color: const Color(0xffF6AB6F),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
