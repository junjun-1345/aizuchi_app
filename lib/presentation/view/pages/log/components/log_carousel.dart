import 'package:aizuchi_app/presentation/model/daily_model.dart';
import 'package:aizuchi_app/presentation/view/pages/log/components/carousel_tiles/emotion_stock_tile.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class LogCarousel extends StatelessWidget {
  const LogCarousel({
    required this.dailyList,
    super.key,
  });

  final List<DailyModel> dailyList;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options:
          CarouselOptions(height: MediaQuery.of(context).size.height * 0.54),
      items: [
        // DaysCarouselTile(
        //   dailyList: dailyList,
        // ),
        EmotionStockTile(dailyList: dailyList),
      ],
    );
  }
}
