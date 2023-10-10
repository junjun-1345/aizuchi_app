import 'package:aizuchi_app/application/interface/chatGPT/chatgpt.dart';
import 'package:aizuchi_app/application/interface/firebase/firestore.dart';
import 'package:aizuchi_app/application/state/waitng_state.dart';
import 'package:aizuchi_app/domain/features/datetime.dart';
import 'package:aizuchi_app/domain/features/prompt.dart';
import 'package:aizuchi_app/domain/models/chatgptmessage.dart';
import 'package:aizuchi_app/domain/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageUsecase {
  MessageUsecase({
    required this.firestore,
    required this.chatGPT,
    required this.waitingStateNotifier,
  });
  final FirestoreInterface firestore;
  final ChatGPTInterface chatGPT;
  final WaitngStateNotifier waitingStateNotifier;

  Future<void> initValitation({
    required void Function() selectEmotionDialog,
  }) async {
    final isTodayMessage =
        await firestore.dailyCheck(CustomDateTime().nowDate());
    if (isTodayMessage == true) {
      return;
    }
    selectEmotionDialog();
  }

  Future<void> sendEmotion(String dailyKey, int num, String text) async {
    waitingStateNotifier.trueState();
    final _newDateMessage = Message(
      key: dailyKey,
      createdAt: DateTime.now(),
      role: "date",
      content: dailyKey,
    );
    firestore.messageCreate(_newDateMessage);

    final _newUserMessage = ChatGPTMessage(
      role: "user",
      content: text,
    );
    final _prompt = ChatGPTMessage(
      content: replyPrompt,
      role: "system",
    );
    final messageList = [_prompt, _newUserMessage];

    firestore.dailyCreate(dailyKey);
    firestore.dailyUpdate("emotion", num);
    final _reply = await chatGPT.sendMessage(messageList);

    final _newClientMessage = Message(
      key: dailyKey,
      createdAt: DateTime.now(),
      role: "assistant",
      content: _reply,
    );

    firestore.messageCreate(_newClientMessage);
    waitingStateNotifier.falseState();
  }

  Future<void> sendMessage(String message) async {
    waitingStateNotifier.trueState();
    final dailyKey = await firestore.dailyGetKey();
    print("dailyKey${dailyKey}");

    final _newUserMessage = Message(
      key: dailyKey,
      createdAt: DateTime.now(),
      role: "user",
      content: message,
    );
    firestore.messageCreate(_newUserMessage);

    final _prompt = ChatGPTMessage(
      content: replyPrompt,
      role: "system",
    );

    final messageList = await firestore.messageReadLimit(10, dailyKey);
    messageList.insert(0, _prompt);

    final _reply = await chatGPT.sendMessage(messageList);

    final _newClientMessage = Message(
      key: dailyKey,
      createdAt: DateTime.now(),
      role: "assistant",
      content: _reply,
    );

    firestore.messageCreate(_newClientMessage);
    waitingStateNotifier.falseState();
  }

  Future<void> finishMessage() async {
    final dailyKey = await firestore.dailyGetKey();
    waitingStateNotifier.trueState();

    final _finish = ChatGPTMessage(
      content: "終了",
      role: "system",
    );

    final _prompt = ChatGPTMessage(
      content: summaryPrompt,
      role: "system",
    );

    firestore.dailyUpdate("endAt", Timestamp.fromDate(DateTime.now()));

    final dailyData = await firestore.dailyRead(CustomDateTime().nowDate());

    final _messageList = await firestore.messageReadToday(
        dailyData["startAt"], dailyData["endAt"]);

    _messageList.insert(0, _prompt);
    _messageList.insert(1, _finish);

    print(_messageList);

    final _reply = await chatGPT.sendMessage(_messageList);

    final _newClientMessage = Message(
      key: dailyKey,
      createdAt: DateTime.now(),
      role: "assistant",
      content: _reply,
    );

    firestore.messageCreate(_newClientMessage);
    firestore.dailyUpdate("title", _reply);

    waitingStateNotifier.falseState();
  }
}
