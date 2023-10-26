import 'package:aizuchi_app/application/di/usecase.dart';
import 'package:aizuchi_app/domain/features/datetime.dart';
import 'package:aizuchi_app/presentation/theme/colors.dart';
import 'package:aizuchi_app/presentation/theme/fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// HACK　冗長なコード
class _LineChart extends ConsumerWidget {
  const _LineChart({required this.isShowingMainData});

  final bool isShowingMainData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logUsecase = ref.read(logUsecaseProvider);

    Future<List<List<FlSpot>>> setSpots() async {
      List<List<FlSpot>> spots = [];
      List<FlSpot> monthSpots = [];
      final monthDateEmotionList = await logUsecase.getThisMonthEmotions();
      for (int i = 1; i < CustomDateTime().lastDayInMonth() + 1; i++) {
        monthSpots
            .add(FlSpot(i.toDouble(), monthDateEmotionList[i - 1].toDouble()));
      }

      List<FlSpot> weekSpots = [];
      final weekDateEmotionList = await logUsecase.getThisWeekEmotions();
      for (int i = 1; i < 8; i++) {
        weekSpots
            .add(FlSpot(i.toDouble(), weekDateEmotionList[i - 1].toDouble()));
      }
      spots.add(weekSpots);
      spots.add(monthSpots);

      return spots;
    }

    return FutureBuilder<List<List<FlSpot>>>(
      future: setSpots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return LineChart(
            isShowingMainData
                ? LineChartData(
                    lineTouchData: lineTouchData2,
                    gridData: gridData,
                    titlesData: titlesData2,
                    borderData: borderData,
                    lineBarsData: [
                      LineChartBarData(
                        isCurved: true,
                        curveSmoothness: 1,
                        color: BrandColor.baseRed.withOpacity(0.5),
                        barWidth: 4,
                        isStrokeCapRound: true,
                        dotData: const FlDotData(show: false),
                        belowBarData: BarAreaData(show: false),
                        spots: snapshot.data![1],
                      ),
                    ],
                    minX: 1,
                    maxX: CustomDateTime().lastDayInMonth().toDouble(),
                    maxY: 5,
                    minY: -1,
                  )
                : LineChartData(
                    lineTouchData: lineTouchData1,
                    gridData: gridData,
                    titlesData: titlesData1,
                    borderData: borderData,
                    lineBarsData: [
                      LineChartBarData(
                        isCurved: true,
                        curveSmoothness: 0,
                        color: BrandColor.baseRed.withOpacity(0.5),
                        barWidth: 8,
                        isStrokeCapRound: true,
                        dotData: const FlDotData(show: false),
                        belowBarData: BarAreaData(show: false),
                        spots: snapshot.data![0],
                      ),
                    ],
                    minX: 1,
                    maxX: 7,
                    maxY: 5,
                    minY: -1,
                  ),
            duration: const Duration(milliseconds: 250),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error.toString()}");
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
      );

  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  LineTouchData get lineTouchData2 => const LineTouchData(
        enabled: false,
      );

  FlTitlesData get titlesData2 => FlTitlesData(
        bottomTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 24,
    );
    String icon;
    switch (value.toInt()) {
      case 0:
        icon = "😭";
        break;
      case 1:
        icon = "🥲";
        break;
      case 2:
        icon = "🙂";
        break;
      case 3:
        icon = "😀";
        break;
      case 4:
        icon = "😆";
        break;
      default:
        return Container();
    }

    return Text(icon, style: style, textAlign: TextAlign.center);
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 40,
      );

  FlGridData get gridData => const FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          bottom:
              BorderSide(color: BrandColor.baseBlue.withOpacity(0.2), width: 4),
          left: const BorderSide(color: Colors.transparent),
          right: const BorderSide(color: Colors.transparent),
          top: const BorderSide(color: Colors.transparent),
        ),
      );
}

class LineChartCard extends HookConsumerWidget {
  const LineChartCard({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const double loginAlign = -1;
    const double signInAlign = 1;
    const Color selectedColor = Colors.white;
    const Color normalColor = Colors.black54;
    final _state = useState(true);
    final isShowingMainData = useState(true);

    Widget toggleButton = Center(
      child: Container(
        width: 160.0,
        height: 32.0,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(
            Radius.circular(50.0),
          ),
        ),
        child: Stack(
          children: [
            AnimatedAlign(
              alignment: Alignment(_state.value ? loginAlign : signInAlign, 0),
              duration: Duration(milliseconds: 300),
              child: Container(
                width: 160.0 * 0.5,
                height: 32.0,
                decoration: BoxDecoration(
                  color: BrandColor.baseRed,
                  borderRadius: BorderRadius.all(
                    Radius.circular(50.0),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                _state.value = true;
                isShowingMainData.value = true;
              },
              child: Align(
                alignment: Alignment(-1, 0),
                child: Container(
                  width: 160.0 * 0.5,
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  child: Text(
                    'Month',
                    style: TextStyle(
                      color: _state.value ? selectedColor : normalColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                _state.value = false;
                isShowingMainData.value = false;
              },
              child: Align(
                alignment: Alignment(1, 0),
                child: Container(
                  width: 160.0 * 0.5,
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  child: Text(
                    'Week',
                    style: TextStyle(
                      color: _state.value ? normalColor : selectedColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    Widget bottomDateTittle = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isShowingMainData.value
              ? "${(CustomDateTime().nowDateDateTime().month - 1)} / ${CustomDateTime().nowDateDateTime().day}"
              : "${(CustomDateTime().nowDateDateTime().month)} / ${CustomDateTime().nowDateDateTime().day - 7}",
          style: BrandText.textLBold,
        ),
        Text(
          "　〜　",
          style: BrandText.textLBold,
        ),
        Text(
          "${CustomDateTime().nowDateDateTime().month} / ${CustomDateTime().nowDateDateTime().day}",
          style: BrandText.textLBold,
        ),
      ],
    );
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      decoration: BoxDecoration(
        color: BrandColor.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                '感情グラフ',
                style: BrandText.textLBold,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 8,
              ),
              toggleButton,
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16, left: 6),
                  child: _LineChart(isShowingMainData: isShowingMainData.value),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              bottomDateTittle,
            ],
          ),
        ],
      ),
    );
  }
}
