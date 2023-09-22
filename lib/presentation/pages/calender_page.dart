import 'package:aizuchi_app/domain/features/datetime.dart';
import 'package:aizuchi_app/domain/models/weekday_model.dart';
import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:aizuchi_app/presentation/theme/colors.dart';
import 'package:aizuchi_app/presentation/theme/fonts.dart';
import 'package:aizuchi_app/presentation/widgets/calender/calender_card.dart';
import 'package:aizuchi_app/presentation/widgets/humburger_menu_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CalenderPage extends HookConsumerWidget {
  const CalenderPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //////////////////////
    // フッター
    //////////////////////
    final Widget footer = Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'chatButton2',
            child: Icon(
              Icons.leaderboard,
            ),
            onPressed: () {
              context.go(PagePath.log);
            },
          ),
          const SizedBox(
            width: 8.0,
          ),
          FloatingActionButton(
            heroTag: 'chatButton2',
            child: Icon(
              Icons.forum,
            ),
            onPressed: () {
              context.go(PagePath.chat);
            },
          ),
        ],
      ),
    );
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "カレンダー",
          style: BrandText.titleS,
        ),
      ),
      drawer: const HumburgerMenu(),
      body: Container(
        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 16.0),
        child: Column(
          children: [
            //カレンダーの中身下へ
            Expanded(child: Carousel()),
            footer,
          ],
        ),
      ),
    );
  }
}

class Carousel extends HookConsumerWidget {
  const Carousel({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenHeight = MediaQuery.of(context).size.height;

    final _currentIndexState = useState(0);
    List<Widget> cardList = [
      // カードの中身を自由に追加してください
      CustomCalender(0),
      CustomCalender(1),
      CustomCalender(2),
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Text(
              "${DateTime.now().year}",
              style: BrandText.textLBold.copyWith(color: BrandColor.black),
            ),
            Text(
              "${DateTime.now().month - _currentIndexState.value}",
              style: BrandText.titleLBold.copyWith(color: BrandColor.black),
            )
          ],
        ),
        CarouselSlider(
          options: CarouselOptions(
            height: screenHeight * 0.5,
            reverse: true,
            initialPage: 0,
            enableInfiniteScroll: false,
            //// カルーセルの高さを指定
            autoPlay: false, // 自動再生を無効にする場合は false に設定
            enlargeCenterPage: false, // 中央のカードを大きく表示しない場合は false に設定
            onPageChanged: (index, reason) {
              _currentIndexState.value = index;
            },
          ),
          items: cardList.map((card) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  child: card,
                );
              },
            );
          }).toList(),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
