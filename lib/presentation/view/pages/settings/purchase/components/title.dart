import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:flutter/material.dart';

class PlanTitle extends StatelessWidget {
  const PlanTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          "1日26円で心の平穏を",
          style: TextStyle(
            color: BrandColor.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          "AIがジャーナリングをお手伝い",
          style: TextStyle(
            color: BrandColor.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
