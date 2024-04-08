import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:flutter/material.dart';

class PlanDescription extends StatelessWidget {
  const PlanDescription({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.check_circle_outline, color: BrandColor.baseRed),
        Text(
          text,
          style: const TextStyle(
            color: BrandColor.black,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
