import 'package:aizuchi_app/application/di/usecase.dart';
import 'package:aizuchi_app/domain/features/datetime.dart';
import 'package:aizuchi_app/presentation/theme/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChartCard extends HookConsumerWidget {
  const ChartCard({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logUsecase = ref.read(logUsecaseProvider);

    double screenWidth = MediaQuery.of(context).size.width;

    Future<List<FlSpot>> setSpots() async {
      List<FlSpot> spots = [];
      final weekDateEmotionList = await logUsecase.getThisWeekEmotions();
      for (int i = 1; i < 8; i++) {
        spots.add(FlSpot(i.toDouble(), weekDateEmotionList[i - 1].toDouble()));
      }
      return spots;
    }

    return Container(
      alignment: Alignment.center,
      width: screenWidth * 0.8,
      height: 440,
      decoration: BoxDecoration(
        color: BrandColor.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.all(2.0),
        child: FutureBuilder<List<FlSpot>>(
            future: setSpots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return LineChart(
                  LineChartData(
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: AxisTitles(
                        sideTitles: _bottomTitles,
                      ),
                      leftTitles: AxisTitles(
                        drawBelowEverything: true,
                        axisNameSize: 24.0,
                        sideTitles: _leftTitles,
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    backgroundColor: Colors.grey[200],
                    minX: 1,
                    maxX: 7,
                    minY: 0,
                    maxY: 6,
                    lineBarsData: [
                      LineChartBarData(
                        color: BrandColor.baseRed,
                        barWidth: 4,
                        dotData: FlDotData(show: true),
                        spots: snapshot.data!,
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error.toString()}");
                ;
              } else {
                return const CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}

SideTitles get _leftTitles => SideTitles(
      showTitles: true,
      interval: 1,
      reservedSize: 40,
      getTitlesWidget: (value, meta) {
        String icon;

        switch (value.toInt()) {
          case 0:
            icon = "";
            break;
          case 1:
            icon = "😭";
            break;
          case 2:
            icon = "🥲";
            break;
          case 3:
            icon = "🙂";
            break;
          case 4:
            icon = "😀";
            break;
          case 5:
            icon = "😆";
            break;
          case 6:
            icon = "";
            break;
          default:
            throw StateError('Invalid');
        }
        return Text(
          icon,
          style: TextStyle(fontSize: 32),
        );
      },
    );

SideTitles get _bottomTitles => SideTitles(
      showTitles: true,
      interval: 1,
      reservedSize: 30,
      getTitlesWidget: (value, meta) {
        String date;
        List<DateTime> thisWeekDatesList = CustomDateTime().thisWeekDatesDat();

        switch (value.toInt()) {
          case 1:
            date =
                "${thisWeekDatesList[value.toInt() - 1].month}/${thisWeekDatesList[value.toInt() - 1].day}";
            break;
          case 2:
            date =
                "${thisWeekDatesList[value.toInt() - 1].month}/${thisWeekDatesList[value.toInt() - 1].day}";
            break;
          case 3:
            date =
                "${thisWeekDatesList[value.toInt() - 1].month}/${thisWeekDatesList[value.toInt() - 1].day}";
            break;
          case 4:
            date =
                "${thisWeekDatesList[value.toInt() - 1].month}/${thisWeekDatesList[value.toInt() - 1].day}";
            break;
          case 5:
            date =
                "${thisWeekDatesList[value.toInt() - 1].month}/${thisWeekDatesList[value.toInt() - 1].day}";
            break;
          case 6:
            date =
                "${thisWeekDatesList[value.toInt() - 1].month}/${thisWeekDatesList[value.toInt() - 1].day}";
            break;
          case 7:
            date =
                "${thisWeekDatesList[value.toInt() - 1].month}/${thisWeekDatesList[value.toInt() - 1].day}";
            break;
          default:
            throw StateError('Invalid');
        }
        return Text(
          date,
          style: TextStyle(fontSize: 16),
        );
      },
    );
