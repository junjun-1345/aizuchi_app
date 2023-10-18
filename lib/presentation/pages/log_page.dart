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
              context.go(PagePath.calender);
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
        // child: LineChartSample1(),
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
          ],
        ),
      ),
    );
  }
}
