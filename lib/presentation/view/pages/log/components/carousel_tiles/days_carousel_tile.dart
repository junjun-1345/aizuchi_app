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
          color: Colors.red,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 16,
              ),
              const DiaryTile(),
              const SizedBox(
                height: 8,
              ),
              const DiaryTile(),
              const SizedBox(
                height: 8,
              ),
              const DiaryTile(),
              const SizedBox(
                height: 8,
              ),
              const DiaryTile(),
              const SizedBox(
                height: 8,
              ),
              const DiaryTile(),
              const SizedBox(
                height: 8,
              ),
              const DiaryTile(),
              const SizedBox(
                height: 8,
              ),
              const DiaryTile(),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(width: 1)),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Text(
                    '1/13(水) 〜 1/19(火)',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(width: 1)),
                    ),
                  ),
                ],
              ),
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
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
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
