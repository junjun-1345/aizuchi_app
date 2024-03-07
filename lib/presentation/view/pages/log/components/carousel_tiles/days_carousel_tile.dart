import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:aizuchi_app/presentation/view/pages/log/components/select_week.dart';
import 'package:flutter/material.dart';

class DaysCarouselTile extends StatelessWidget {
  const DaysCarouselTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 16,
              ),
              DiaryTile(),
              SizedBox(
                height: 8,
              ),
              DiaryTile(),
              SizedBox(
                height: 8,
              ),
              DiaryTile(),
              SizedBox(
                height: 8,
              ),
              DiaryTile(),
              SizedBox(
                height: 8,
              ),
              DiaryTile(),
              SizedBox(
                height: 8,
              ),
              DiaryTile(),
              SizedBox(
                height: 8,
              ),
              DiaryTile(),
              SizedBox(
                height: 24,
              ),
              SelectWeekPart(),
            ],
          ),
        ),
      ),
    );
  }
}

class DiaryTile extends StatelessWidget {
  const DiaryTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: BrandColor.base,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Row(
        children: [
          SizedBox(
            width: 16,
          ),
          Text(
            '火',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Text(
              'カフェで課題をした後、梅田で田中先輩とご飯に行った。',
              style: TextStyle(fontSize: 10),
              maxLines: 2,
            ),
          ),
          SizedBox(
            width: 8,
          ),
        ],
      ),
    );
  }
}
