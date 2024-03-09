import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:aizuchi_app/presentation/model/daily_model.dart';
import 'package:aizuchi_app/presentation/view/pages/log/components/select_week.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class DaysCarouselTile extends StatelessWidget {
  const DaysCarouselTile({
    required this.dailyList,
    Key? key,
  }) : super(key: key);

  final List<DailyModel> dailyList;

  @override
  Widget build(BuildContext context) {
    // ロケールデータを初期化
    initializeDateFormatting(Localizations.localeOf(context).languageCode);

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
                height: 16,
              ),
              DiaryTile(
                  day: DateFormat.EEEE('ja').format(dailyList[0].createdAt)[0],
                  summary: dailyList[0].summary),
              const SizedBox(
                height: 16,
              ),
              const SelectWeekPart(),
            ],
          ),
        ),
      ),
    );
  }
}

class DiaryTile extends StatelessWidget {
  const DiaryTile({
    required this.day,
    this.summary,
    Key? key,
  }) : super(key: key);

  final String day;
  final String? summary;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.06,
      decoration: BoxDecoration(
        color: BrandColor.base,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 16,
          ),
          Text(
            day,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Text(
              summary ?? '',
              style: const TextStyle(fontSize: 10),
              maxLines: 2,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
        ],
      ),
    );
  }
}
