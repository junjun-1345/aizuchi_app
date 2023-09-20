import 'package:aizuchi_app/presentation/widgets/log/list_card.dart';
import 'package:aizuchi_app/presentation/widgets/log/chart_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ButtomCardWidget extends ConsumerWidget {
  const ButtomCardWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Widget> cardList = [
      ListCard(),
      ChartCard(),
    ];

    double screenHeight = MediaQuery.of(context).size.height;

    return CarouselSlider(
      options: CarouselOptions(
        height: screenHeight * 0.5,
        //// カルーセルの高さを指定
        enableInfiniteScroll: false, //ループさせない場合
        autoPlay: false, // 自動再生を無効にする場合は false に設定
        enlargeCenterPage: false, // 中央のカードを大きく表示しない場合は false に設定
      ),
      items: cardList.map((card) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              child: card,
            );
          },
        );
      }).toList(),
    );
  }
}
