import 'package:aizuchi_app/application/state/message_state.dart';
import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:aizuchi_app/presentation/widgets/humburger_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../theme/colors.dart';
import '../theme/fonts.dart';

class ChatPage extends HookConsumerWidget {
  const ChatPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messageState = ref.watch(messageProvider);
    final isWaiting = useState(false);
    final isKeyboard = useState(false);

    final messageController = useTextEditingController(text: "");

    void KeyboardStateToTrue() {
      isKeyboard.value = true;
    }

    void KeyboardStateToFalse() {
      isKeyboard.value = false;
    }

    final screenWidth = MediaQuery.of(context).size.width;

    void sendMessage() async {
      // chatGPTにメッセージを送る
    }

    void finishMessage() async {
      // その日のメッセージの要約を追加
      // メモに切り替え
      // 入力を禁止
    }

    //
    // ユーザーチャットコンテント
    //
    Widget userChatContent(String message) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.centerRight,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: screenWidth * 0.8,
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: BrandColor.white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 7,
                  horizontal: 16,
                ),
                child: Text(message
                    // style: BrandText.bodyM,
                    ),
              ),
            ),
          ),
        ),
      );
    }

    //
    // クライアントチャットコンテント
    //
    Widget clientChatContent(String message) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: screenWidth * 0.7,
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: BrandColor.baseRed,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    child: Text(
                      message,
                      style: TextStyle(
                        color: BrandColor.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
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
              // context.go(PagePath.calender);
              context.go(PagePath.start);
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
              // context.go(PagePath.log);
              context.go(PagePath.start);
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
                  finishMessage();
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
                    }
                  },
                  controller: messageController,
                  autofocus: true,
                  onEditingComplete: () {
                    KeyboardStateToFalse();
                  },
                ),
              ),

              if (!isWaiting.value)
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
                    }
                  },
                  icon: !isWaiting.value
                      ? const Icon(Icons.send)
                      : const SizedBox(
                          width: 12,
                          height: 12,
                          child: CircularProgressIndicator(),
                        ),
                ),
              // 送信中
              if (isWaiting.value)
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
    final chatArea = ListView.builder(
      itemCount: messageState.length,
      itemBuilder: (context, index) {
        final message = messageState[index];
        // systemロールのメッセージは表示しない
        if (message.role == "assistant") {
          return clientChatContent(message.content);
        }
        if (message.role == "user") {
          return userChatContent(message.content);
        } else {
          return const SizedBox();
        }
      },
    );

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
            "チャット",
            style: BrandText.titleS,
          ),
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
