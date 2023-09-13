import 'package:aizuchi_app/application/interface/chatGPT/chatgpt.dart';
import 'package:aizuchi_app/application/interface/firebase/firestore.dart';
import 'package:aizuchi_app/application/state/waitng.dart';
import 'package:aizuchi_app/domain/features/datetime.dart';
import 'package:aizuchi_app/domain/features/prompt.dart';
import 'package:aizuchi_app/domain/models/chatgptmessage.dart';
import 'package:aizuchi_app/domain/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageUsecase {
  MessageUsecase({
    required this.firestore,
    required this.chatGPT,
    required this.waitingNotifier,
  });
  final FirestoreInterface firestore;
  final ChatGPTInterface chatGPT;
  final WaitngNotifier waitingNotifier;

  Future<void> initValitation({
    required void Function() function,
  }) async {
    // 当日の会話があるかチェック
    final flag = await firestore.dailyCheck("date", CustomDateTime().nowDate());

    // true　↓　false　投げる
    if (flag == true) {
      return;
    }

    // 感情選択
    function();
  }

  Future<void> sendEmotion(int num, String text) async {
    waitingNotifier.trueState();
    final _newUserMessage = ChatGPTMessage(
      role: "user",
      content: text,
    );
    final _prompt = ChatGPTMessage(
      content: replyPrompt,
      role: "system",
    );
    final messageList = [_prompt, _newUserMessage];

    firestore.dailyCreate();
    firestore.dailyUpdate("emotion", num);
    final _reply = await chatGPT.sendMessage(messageList);

    final _newClientMessage = Message(
      createdAt: DateTime.now(),
      role: "assistant",
      content: _reply,
    );

    firestore.messageCreate(_newClientMessage);
    waitingNotifier.falseState();
  }

  Future<void> sendMessage(String message) async {
    waitingNotifier.trueState();
    //メッセージを保存
    final _newUserMessage = Message(
      createdAt: DateTime.now(),
      role: "user",
      content: message,
    );
    firestore.messageCreate(_newUserMessage);

    final _prompt = ChatGPTMessage(
      content: replyPrompt,
      role: "system",
    );

    final messageList = await firestore.messageReadLimit(10);
    messageList.insert(1, _prompt);
    final _reply = await chatGPT.sendMessage(messageList);

    final _newClientMessage = Message(
      createdAt: DateTime.now(),
      role: "assistant",
      content: _reply,
    );

    firestore.messageCreate(_newClientMessage);
    waitingNotifier.falseState();
  }

  Future<void> finishMessage() async {
    waitingNotifier.trueState();

    final _prompt = ChatGPTMessage(
      content: summaryPrompt,
      role: "system",
    );

    firestore.dailyUpdate("endAt", Timestamp.fromDate(DateTime.now()));

    final dailyData = await firestore.dailyRead(CustomDateTime().nowDate());

    final _messageList = await firestore.messageReadToday(
        dailyData["startAt"], dailyData["endAt"]);

    _messageList.insert(1, _prompt);

    print("メッセージリスト$_messageList");

    final _reply = await chatGPT.sendMessage(_messageList);

    final _newClientMessage = Message(
      createdAt: DateTime.now(),
      role: "assistant",
      content: _reply,
    );

    firestore.messageCreate(_newClientMessage);
    firestore.dailyUpdate("title", _reply);

    waitingNotifier.falseState();
  }
}
