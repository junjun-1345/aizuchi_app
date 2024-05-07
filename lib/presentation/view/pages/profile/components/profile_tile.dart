import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    required this.title,
    required this.currentData,
    this.withBorder = false,
    super.key,
  });

  final String title;
  final String currentData;
  final bool withBorder;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        decoration: BoxDecoration(
          color: BrandColor.white,
          borderRadius: BorderRadius.circular(10),
          border: withBorder
              ? Border.all(width: 0.5, color: BrandColor.baseRed)
              : null,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                currentData,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
