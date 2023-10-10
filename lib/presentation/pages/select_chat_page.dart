import 'package:aizuchi_app/application/state/dailykey_state.dart';
import 'package:aizuchi_app/domain/features/datetime.dart';
import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:aizuchi_app/presentation/theme/colors.dart';
import 'package:aizuchi_app/presentation/widgets/chat/select_chat_widget.dart';
import 'package:aizuchi_app/presentation/widgets/humburger_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../theme/fonts.dart';

class SelectChatPage extends HookConsumerWidget {
  const SelectChatPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dailyKeyState = ref.watch(dailykeyStateNotifierProvider);

    //////////////////////
    // レイアウトの構成
    //////////////////////
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          "${CustomDateTime().stringToDateTime(dailyKeyState).month}月${CustomDateTime().stringToDateTime(dailyKeyState).day}日のチャット",
          style: BrandText.titleS,
        ),
      ),
      drawer: const HumburgerMenu(),
      body: Container(
        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(child: SelectChatWidget()),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                      width: 0.25, //枠線の太さ
                      color: Colors.black38),
                ),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        child: const Text(
                          '今日に戻る',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: OutlinedButton.styleFrom(
                            backgroundColor: BrandColor.baseBlue,
                            foregroundColor: BrandColor.baseBlue,
                            minimumSize: Size.fromHeight(48),
                            shape: const StadiumBorder(),
                            side: const BorderSide(color: BrandColor.baseBlue)),
                        onPressed: () {
                          context.go(PagePath.chat);
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    FloatingActionButton(
                      heroTag: 'chatButton1',
                      child: Icon(
                        Icons.calendar_today,
                      ),
                      onPressed: () {
                        context.go(PagePath.calender);
                      },
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    FloatingActionButton(
                      heroTag: 'chatButton2',
                      child: Icon(
                        Icons.leaderboard,
                      ),
                      onPressed: () {
                        context.go(PagePath.log);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
