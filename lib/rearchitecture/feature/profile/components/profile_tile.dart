import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:flutter/material.dart';

class ReProfileTile extends StatelessWidget {
  const ReProfileTile({
    required this.title,
    required this.value,
    super.key,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: BrandColor.baseRed),
          child: Center(
            child: Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    color: BrandColor.base,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 18,
                    color: BrandColor.base,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
