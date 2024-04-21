import 'package:aizuchi_app/domain/entity/enums/emotion.dart';
import 'package:aizuchi_app/domain/entity/models/calendar.dart';
import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class CalenderItem extends StatelessWidget {
  final CalendarEntity data;
  const CalenderItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final bool isCurrentMonth = data.date.month == DateTime.now().month;
    final double opacity = isCurrentMonth ? 1.0 : 0.3;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => context.router.push(
          LimitMessageRoute(selectedDate: data.date),
        ),
        splashColor: Colors.black.withOpacity(0.2),
        highlightColor: Colors.black.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: BrandColor.white,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Center(
              child: Column(
                children: [
                  Text(
                    '${data.date.day}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: BrandColor.textBlack.withOpacity(opacity),
                    ), // スタイルを再利用
                  ),
                  Text(
                    data.emotion != null && isCurrentMonth
                        ? EmotionTypeExtension.emotionValues[data.emotion] ?? ''
                        : '',
                    style: const TextStyle(
                      color: BrandColor.textBlack,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
