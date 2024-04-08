import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:flutter/material.dart';

class MonthlyPlanContent extends StatelessWidget {
  const MonthlyPlanContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "月額プラン",
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: BrandColor.baseRed),
            ),
            Text(
              "¥650/月",
              style: TextStyle(
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
