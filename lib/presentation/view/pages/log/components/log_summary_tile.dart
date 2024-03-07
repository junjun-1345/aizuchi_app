import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:flutter/material.dart';

class LogSummaryTile extends StatelessWidget {
  const LogSummaryTile({
    required this.createdAt,
    required this.activeDays,
    required this.messageAmount,
    super.key,
  });

  final DateTime createdAt;
  final int activeDays;
  final int messageAmount;

  @override
  Widget build(BuildContext context) {
    final int registeredDays = DateTime.now().difference(createdAt).inDays;
    return Container(
      height: MediaQuery.of(context).size.height * 0.12,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        color: BrandColor.baseRed,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SummaryPart(
              icon: Icons.check_circle_outline,
              title: '登録から',
              value: registeredDays.toString(),
              unit: '日',
            ),
            SummaryPart(
              icon: Icons.chat_bubble_outline_sharp,
              title: '会話数',
              value: messageAmount.toString(),
              unit: '回',
            ),
            SummaryPart(
              icon: Icons.chat_bubble_outline_rounded,
              title: '会話した日',
              value: activeDays.toString(),
              unit: '日',
            ),
          ],
        ),
      ),
    );
  }
}

class SummaryPart extends StatelessWidget {
  const SummaryPart({
    required this.icon,
    required this.title,
    required this.value,
    required this.unit,
    super.key,
  });

  final IconData? icon;
  final String title;
  final String value;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white,
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            Text(
              unit,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ],
        )
      ],
    );
  }
}