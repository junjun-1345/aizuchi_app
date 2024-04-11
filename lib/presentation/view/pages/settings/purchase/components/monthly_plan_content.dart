import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:flutter/material.dart';

class MonthlyPlanContent extends StatelessWidget {
  const MonthlyPlanContent({required this.price, super.key});

  final int price;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "月額プラン",
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: BrandColor.baseRed),
            ),
            Text(
              "¥$price/月",
              style: const TextStyle(
                  color: BrandColor.baseRed,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ],
    );
  }
}
