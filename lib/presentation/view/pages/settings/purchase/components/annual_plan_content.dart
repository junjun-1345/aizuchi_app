import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:flutter/material.dart';

class AnnualPlanContent extends StatelessWidget {
  const AnnualPlanContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: BrandColor.baseRed,
                borderRadius: BorderRadius.circular(50.0),
              ),
              padding:
                  const EdgeInsets.symmetric(vertical: 2.0, horizontal: 12.0),
              child: const Text(
                "おすすめ",
                style: TextStyle(
                    color: BrandColor.white, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "年額プラン",
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: BrandColor.baseRed),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "¥500/月",
                  style: TextStyle(
                      color: BrandColor.baseRed,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  "※12ヶ月分一括 ¥6,000",
                  style: TextStyle(
                      color: BrandColor.baseRed,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          decoration: BoxDecoration(
            color: BrandColor.baseRed,
            borderRadius: BorderRadius.circular(50.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 48.0),
          child: const Text(
            "7日間無料で始める",
            style: TextStyle(
                color: BrandColor.white,
                fontWeight: FontWeight.w700,
                fontSize: 16),
          ),
        ),
      ],
    );
  }
}
