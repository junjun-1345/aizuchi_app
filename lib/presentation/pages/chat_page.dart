import 'package:aizuchi_app/application/di/usecase.dart';
import 'package:aizuchi_app/application/state/todaykey.dart';
import 'package:aizuchi_app/application/state/waitng.dart';
import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:aizuchi_app/presentation/widgets/chat/chat_widget.dart';
import 'package:aizuchi_app/presentation/dialog/dialog_widget.dart';
import 'package:aizuchi_app/presentation/widgets/humburger_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../theme/fonts.dart';

class ChatPage extends HookConsumerWidget {
  const ChatPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messageUsecase = ref.read(messageUsecaseProvider);
    // final accountUsecase = ref.read(accountUsecaseProvider);
    final dailyKeyStateStr = ref.watch(todaykeyNotifierProvider);
    final dailyKeyNotifier = ref.read(todaykeyNotifierProvider.notifier);

    final dailyKeyStateDate = DateTime.parse(dailyKeyStateStr);

    final isWaiting = ref.watch(waitngNotifierProvider);
    final isKeyboard = useState(false);
    // final isFinish = useState(true);

    final messageController = useTextEditingController(text: "");

    useEffect(() {
      messageUsecase.initValitation(selectEmotionDialog: () {
        showEmotionDialog(context);
      });
    });

    void KeyboardStateToTrue() {
      isKeyboard.value = true;
    }

    void KeyboardStateToFalse() {
      isKeyboard.value = false;
    }

    void sendMessage() async {
      messageUsecase.sendMessage(messageController.text);
      // chatGPTにメッセージを送る
    }

    //
    // キーボードがない場合
    //
    final emptyKeyboard = Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              child: const Text(
                'テキストを入力',
                style: TextStyle(color: Color.fromARGB(125, 51, 51, 51)),
              ),
              style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.white,
                  minimumSize: Size.fromHeight(48),
                  shape: const StadiumBorder(),
                  side: const BorderSide(color: Colors.white)),
              onPressed: () {
                KeyboardStateToTrue();
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
              // messageUsecase.init(callback);
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
    );

    //
    // キーボードがある場合
    //
    final existKeyboard = Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  messageUsecase.finishMessage();
                },
                child: Text("終了"),
                style: TextButton.styleFrom(
                  shape: StadiumBorder(),
                ),
              ),
              SizedBox(width: 4),
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  onSubmitted: (value) async {
                    if (messageController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('メッセージを入力してください'),
                        ),
                      );
                    } else {
                      // 送信
                      sendMessage();
                      messageController.clear();
                    }
                  },
                  controller: messageController,
                  autofocus: true,
                  onEditingComplete: () {
                    KeyboardStateToFalse();
                  },
                ),
              ),

              if (!isWaiting)
                IconButton(
                  onPressed: () async {
                    if (messageController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('メッセージを入力してください'),
                        ),
                      );
                    } else {
                      sendMessage();
                      messageController.clear();
                    }
                  },
                  icon: !isWaiting
                      ? const Icon(Icons.send)
                      : const SizedBox(
                          width: 12,
                          height: 12,
                          child: CircularProgressIndicator(),
                        ),
                ),
              // 送信中
              if (isWaiting)
                const IconButton(
                  onPressed: null,
                  icon: SizedBox(
                    width: 12,
                    height: 12,
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          ),
        ),
      ],
    );

    //
    // チャットエリア
    //
    const chatArea = ChatWidget();

    // ListView.builder(
    //   itemCount: messageState.length,
    //   itemBuilder:
    // );

    //
    // フッターエリア
    //
    final chatFooter = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        isKeyboard.value ? existKeyboard : emptyKeyboard,
      ],
    );

    //////////////////////
    // レイアウトの構成
    //////////////////////
    return GestureDetector(
      onTap: () => KeyboardStateToFalse(),
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text(
            "${dailyKeyStateDate.month}月${dailyKeyStateDate.day}日のチャット",
            style: BrandText.titleS,
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.manage_history,
                ),
                onPressed: () {
                  dailyKeyNotifier.initState();
                }),
          ],
        ),
        drawer: const HumburgerMenu(),
        body: Container(
          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(child: chatArea),
              chatFooter,
            ],
          ),
        ),
      ),
    );
  }
}
