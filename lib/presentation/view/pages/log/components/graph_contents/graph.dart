import 'package:aizuchi_app/domain/entity/enums/day_of_week.dart';
import 'package:aizuchi_app/domain/entity/enums/emotion.dart';
import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:aizuchi_app/domain/utils/datetime_utils.dart';
import 'package:aizuchi_app/presentation/model/daily_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class EmotionGraphLineChart extends StatelessWidget {
  const EmotionGraphLineChart({
    super.key,
    required this.selectedMonthlyPage,
    required this.dailyList,
  });

  final bool selectedMonthlyPage;
  final List<DailyModel> dailyList;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final List<FlSpot> dailyFlSpotList = [];

    for (var daily in dailyList) {
      final int y = daily.emotion!.index + 1;

      if (selectedMonthlyPage) {
        final int x = daily.createdAt.day;

        dailyFlSpotList.add(FlSpot(x.toDouble(), y.toDouble()));
      } else {
        final int x = daily.createdAt.weekday - 1;
        dailyFlSpotList.add(FlSpot(x.toDouble(), y.toDouble()));
      }
    }

    // データが空の場合の対策
    if (dailyFlSpotList.isEmpty) {
      return const Center(
        child: Text("データが存在しません。",
            style: TextStyle(fontSize: 16, color: Colors.black)),
      );
    }

    return LineChart(
      LineChartData(
        // タッチ操作時の設定
        lineTouchData: const LineTouchData(
          handleBuiltInTouches: true, // タッチ時のアクションの有無
          getTouchedSpotIndicator: defaultTouchedIndicators, // インジケーターの設定
          touchTooltipData: LineTouchTooltipData(
            // ツールチップの設定
            getTooltipItems: defaultLineTooltipItem, // 表示文字設定
            // tooltipColor: Colors.white, // 背景の色
            tooltipRoundedRadius: 2.0, // 角丸
          ),
        ),
        // 背景のグリッド線の設定
        gridData: FlGridData(
          show: false, // 背景のグリッド線の有無
          drawVerticalLine: true, // 水平方向のグリッド線の有無
          horizontalInterval: 1.0, // 背景グリッドの横線間隔
          verticalInterval: 1.0, // 背景グリッドの縦線間隔
          getDrawingHorizontalLine: (value) {
            // 背景グリッドの横線設定
            return const FlLine(
              color: Color(0xff37434d), // 背景横線の色
              strokeWidth: 1.0, // 背景横線の太さ
            );
          },
          getDrawingVerticalLine: (value) {
            // 背景グリッドの縦線設定
            return const FlLine(
              color: Color(0xff37434d), // 背景縦線の色
              strokeWidth: 1.0, // 背景縦線の太さ
            );
          },
        ),

        // グラフのタイトル設定
        titlesData: FlTitlesData(
          show: true, // タイトルの有無
          bottomTitles: AxisTitles(
            axisNameSize: 22.0, // タイトルの表示エリアの幅
            sideTitles: SideTitles(
              // サイドタイトル設定
              showTitles: true, // サイドタイトルの有無
              interval: 1.0, // サイドタイトルの表示間隔
              reservedSize: 40.0, // サイドタイトルの表示エリアの幅
              getTitlesWidget: selectedMonthlyPage
                  ? monthlyBottomTitleWidgets
                  : weeklyBottomTitleWidgets, // // サイドタイトルの表示内容
            ),
          ),
          rightTitles: const AxisTitles(), // 上記と同じため割愛
          topTitles: const AxisTitles(),
          leftTitles: const AxisTitles(
            axisNameSize: 24.0, // タイトルの表示エリアの幅
            sideTitles: SideTitles(
              showTitles: true, // 左タイトルの有無
              interval: 1.0, // 左タイトルの表示間隔
              reservedSize: 32.0, // 左タイトルの表示エリアの幅
              getTitlesWidget: leftTitleWidgets, // 左タイトルの表示内容
            ),
          ),
        ),

        // グラフの外枠線
        borderData: FlBorderData(
          show: true, // 外枠線の有無
          border: Border.all(
            // 外枠線の色
            color: const Color(0xff37434d),
          ),
        ),

        // グラフのx軸y軸のの表示数
        minX: 0.0,
        maxX: selectedMonthlyPage ? now.lastDayOfMonth.day.toDouble() : 6.0,
        minY: 0.0,
        maxY: 6.0,

        // チャート線の設定
        lineBarsData: [
          LineChartBarData(
            spots: dailyFlSpotList,

            color: BrandColor.baseRed,
            isCurved: false, // チャート線を曲線にするか折れ線にするか
            barWidth: 2.0, // チャート線幅
            isStrokeCapRound: false, // チャート線の開始と終了がQubicかRoundか（？）
            dotData: FlDotData(
              show: true, // 座標のドット表示の有無
              getDotPainter: (spot, percent, barData, index) =>
                  FlDotCirclePainter(
                // ドットの詳細設定
                radius: 2.0,
                color: BrandColor.baseRed,
                strokeWidth: 2.0,
                strokeColor: BrandColor.baseRed,
              ),
            ),
            belowBarData: BarAreaData(
              // チャート線下部に色を付ける場合の設定
              show: false, // チャート線下部の表示の有無
            ),
          ),
        ],
      ),
    );
  }
}

Widget weeklyBottomTitleWidgets(
  double value,
  TitleMeta meta,
) {
  const style = TextStyle(
    color: Color(0xff68737d),
    fontWeight: FontWeight.bold,
    fontSize: 16.0,
  );
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = Text(DayOfWeek.values[value.toInt()].name("jp"), style: style);
      break;
    case 1:
      text = Text(DayOfWeek.values[value.toInt()].name("jp"), style: style);
      break;
    case 2:
      text = Text(DayOfWeek.values[value.toInt()].name("jp"), style: style);
      break;
    case 3:
      text = Text(DayOfWeek.values[value.toInt()].name("jp"), style: style);
      break;
    case 4:
      text = Text(DayOfWeek.values[value.toInt()].name("jp"), style: style);
      break;
    case 5:
      text = Text(DayOfWeek.values[value.toInt()].name("jp"), style: style);
      break;
    case 6:
      text = Text(DayOfWeek.values[value.toInt()].name("jp"), style: style);
      break;
    default:
      text = Text(DayOfWeek.values[value.toInt()].name("jp"), style: style);
      break;
  }

  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: text,
  );
}

Widget leftTitleWidgets(
  double value,
  TitleMeta meta,
) {
  const style = TextStyle(
    color: Color(0xff68737d),
    fontWeight: FontWeight.bold,
    fontSize: 24.0,
  );
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text("", style: style);
      break;
    case 1:
      text = Text(
          EmotionTypeExtension
                  .emotionValues[EmotionType.values[value.toInt() - 1]] ??
              "",
          style: style);
      break;
    case 2:
      text = Text(
          EmotionTypeExtension
                  .emotionValues[EmotionType.values[value.toInt() - 1]] ??
              "",
          style: style);
      break;
    case 3:
      text = Text(
          EmotionTypeExtension
                  .emotionValues[EmotionType.values[value.toInt() - 1]] ??
              "",
          style: style);
      break;
    case 4:
      text = Text(
          EmotionTypeExtension
                  .emotionValues[EmotionType.values[value.toInt() - 1]] ??
              "",
          style: style);
      break;
    case 5:
      text = Text(
          EmotionTypeExtension
                  .emotionValues[EmotionType.values[value.toInt() - 1]] ??
              "",
          style: style);
      break;
    default:
      text = const Text("", style: style);
  }

  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: text,
  );
}

Widget monthlyBottomTitleWidgets(
  double value,
  TitleMeta meta,
) {
  const style = TextStyle(
    color: Color(0xff68737d),
    fontWeight: FontWeight.bold,
    fontSize: 16.0,
  );
  Widget text;
  switch (value.toInt()) {
    case 1:
      text = const Text('1', style: style);
      break;
    case 7:
      text = const Text('7', style: style);
      break;
    case 14:
      text = const Text('14', style: style);
      break;
    case 21:
      text = const Text('21', style: style);
      break;
    case 28:
      text = const Text('28', style: style);
      break;
    default:
      text = const Text('', style: style);
      break;
  }

  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: text,
  );
}
