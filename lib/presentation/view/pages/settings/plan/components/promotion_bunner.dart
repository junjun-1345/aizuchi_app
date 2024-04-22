import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:aizuchi_app/presentation/view/components/app_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class PromotionBunner extends StatelessWidget {
  const PromotionBunner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: BrandColor.baseRed,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "はじめの７日間無料",
            style: TextStyle(
                color: BrandColor.white,
                fontSize: 24,
                fontWeight: FontWeight.w800),
          ),
          AppButton.base(
            width: 200,
            style: ElevatedButton.styleFrom(
              fixedSize: const Size.fromWidth(200),
              foregroundColor: BrandColor.baseRed,
              backgroundColor: BrandColor.white,
              shape: const StadiumBorder(),
            ),
            onPressed: () {
              context.router.push(const PurchaseRoute());
            },
            text: 'プレミアム　>',
            textStyle: TextStyle(fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}
