import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:flutter/material.dart';

class StartDivider extends StatelessWidget {
  const StartDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: Divider(
            color: Colors.black,
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Text(
          'または',
          style: TextStyle(
            color: BrandColor.baseRed,
            fontSize: 16,
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Expanded(
          child: Divider(
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
