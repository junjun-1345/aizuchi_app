import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:aizuchi_app/presentation/theme/fonts.dart';
import 'package:aizuchi_app/presentation/widgets/humburger_menu_widget.dart';
import 'package:aizuchi_app/presentation/widgets/log/buttom_card_widget.dart';
import 'package:aizuchi_app/presentation/widgets/log/top_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LogPage extends ConsumerWidget {
  const LogPage({super.key});

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
            heroTag: 'chatButton1',
            child: Icon(
              Icons.calendar_today,
            ),
            onPressed: () {
              // context.go(PagePath.calender);
              // messageUsecase.init(callback);
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

    //////////////////////
    // レイアウトの構成
    //////////////////////
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "ログ",
          style: BrandText.titleS,
        ),
      ),
      drawer: const HumburgerMenu(),
      body: Container(
        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 16.0),
        child: Column(
          children: [
            Expanded(
                child: Column(
              children: [
                SizedBox(
                  height: 24,
                ),
                // 画面上部
                TopCardWidget(),
                SizedBox(
                  height: 24,
                ),
                ButtomCardWidget()
              ],
            )),
            footer,
            //     SizedBox(
            //       height: 24,
            //     ),
            //     // 画面上部
            //     TopCardWidget(),
            //     SizedBox(
            //       height: 24,
            //     ),
            //     // 画面下部
            //     CarouselSlider(
            //       options: CarouselOptions(
            //         height: 440,
            //         //// カルーセルの高さを指定
            //         enableInfiniteScroll: false, //ループさせない場合
            //         autoPlay: false, // 自動再生を無効にする場合は false に設定
            //         enlargeCenterPage: false, // 中央のカードを大きく表示しない場合は false に設定
            //       ),
            //       items: cardList.map((card) {
            //         return Builder(
            //           builder: (BuildContext context) {
            //             return Container(
            //               height: MediaQuery.of(context).size.height,
            //               width: MediaQuery.of(context).size.width,
            //               margin: EdgeInsets.symmetric(horizontal: 5.0),
            //               child: card,
            //             );
            //           },
            //         );
            //       }).toList(),
            //     ),
          ],
        ),
      ),
    );

    // return Base(
    //   title: "ログ",
    //   footerButton: footerButton,
    //   child: Column(
    //     children: [
    //       //スペーシング
    //       SizedBox(
    //         height: 24,
    //       ),
    //       TopCardWidget(),
    //       SizedBox(
    //         height: 24,
    //       ),
    //       CarouselSlider(
    //         options: CarouselOptions(
    //           height: 440,
    //           //// カルーセルの高さを指定
    //           enableInfiniteScroll: false, //ループさせない場合
    //           autoPlay: false, // 自動再生を無効にする場合は false に設定
    //           enlargeCenterPage: false, // 中央のカードを大きく表示しない場合は false に設定
    //         ),
    //         items: cardList.map((card) {
    //           return Builder(
    //             builder: (BuildContext context) {
    //               return Container(
    //                 height: MediaQuery.of(context).size.height,
    //                 width: MediaQuery.of(context).size.width,
    //                 margin: EdgeInsets.symmetric(horizontal: 5.0),
    //                 child: card,
    //               );
    //             },
    //           );
    //         }).toList(),
    //       ),
    //     ],
    //   ),
    // );
  }
}
