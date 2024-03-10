import 'package:aizuchi_app/domain/entity/enums/emotion.dart';
import 'package:aizuchi_app/domain/entity/enums/message.dart';
import 'package:aizuchi_app/domain/entity/models/message.dart';
import 'package:aizuchi_app/domain/interactor/messages_interactor.dart';
import 'package:aizuchi_app/infrastructure/repositories/gpt_repository_impl.dart';
import 'package:aizuchi_app/infrastructure/repositories/message_db_repositories_impl.dart';
import 'package:aizuchi_app/infrastructure/repositories/gemini_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Gemini API Connection Test', () {
    test('Reply method should connect to API and get a response', () async {
      // リポジトリのインスタンスを作成
      final geminiRepository = GenimiRepositoryImpl();
      final messageDBRepository = MessageDBRepositoryImpl();
      final gptRepository = GptRepositoryImpl();

      final repository = MessagesInteractor(
          messageDBRepository, geminiRepository, gptRepository);
      // テスト用のメッセージリストを作成
      final messages = [
        MessageEntity(
            id: "2024_2_3",
            createdAt: DateTime(2024, 2, 3, 10, 00),
            content: "",
            type: MessageType.datetime),
        MessageEntity(
            id: "2024_2_3_1",
            createdAt: DateTime(2024, 2, 3, 10, 10),
            content: "",
            type: MessageType.emotion),
        MessageEntity(
            id: "2024_2_3_2",
            createdAt: DateTime(2024, 2, 3, 10, 20),
            content: "今日はどんな一日だったのですか？",
            type: MessageType.assistant),
        MessageEntity(
            id: "2024_2_3_3",
            createdAt: DateTime(2024, 2, 3, 10, 30),
            content: "楽しかったです！",
            type: MessageType.user),
        MessageEntity(
            id: "2024_2_3_4",
            createdAt: DateTime(2024, 2, 3, 10, 40),
            content: "それは良かったです！どんなことをしたのですか？",
            type: MessageType.assistant),
        MessageEntity(
            id: "2024_2_3_5",
            createdAt: DateTime(2024, 2, 3, 10, 50),
            content: "今日はみんなで勉強をしました",
            type: MessageType.user),
        MessageEntity(
            id: "2024_2_3_6",
            createdAt: DateTime(2024, 2, 3, 11, 00),
            content: "そして昼ごはんを食べました",
            type: MessageType.user),
        MessageEntity(
            id: "2024_2_3_7",
            createdAt: DateTime(2024, 2, 3, 11, 10),
            content: "それは楽しそうですね！",
            type: MessageType.assistant),
        MessageEntity(
            id: "2024_2_3_8",
            createdAt: DateTime(2024, 2, 3, 11, 20),
            content: "はい！",
            type: MessageType.user),
        MessageEntity(
            id: "2024_2_4",
            createdAt: DateTime(2024, 2, 4, 10, 00),
            content: "",
            type: MessageType.datetime),
        MessageEntity(
            id: "2024_2_4_1",
            createdAt: DateTime(2024, 2, 4, 10, 10),
            content: "",
            type: MessageType.emotion),
        MessageEntity(
            id: "2024_2_4_1_5",
            createdAt: DateTime(2024, 2, 4, 10, 15),
            content: "話し相手になってください",
            type: MessageType.user),
        MessageEntity(
            id: "2024_2_4_2",
            createdAt: DateTime(2024, 2, 4, 10, 20),
            content: "今日はどんな一日だったのですか？",
            type: MessageType.assistant),
        MessageEntity(
            id: "2024_2_4_3",
            createdAt: DateTime(2024, 2, 4, 10, 30),
            content: "楽しかったです！",
            type: MessageType.user),
        MessageEntity(
            id: "2024_2_4_4",
            createdAt: DateTime(2024, 2, 4, 10, 40),
            content: "それは良かったです！どんなことをしたのですか？",
            type: MessageType.assistant),
        MessageEntity(
            id: "2024_2_4_5",
            createdAt: DateTime(2024, 2, 4, 10, 50),
            content: "今日はみんなで勉強をしました そして昼ごはんを食べました",
            type: MessageType.user),
        MessageEntity(
            id: "2024_2_4_7",
            createdAt: DateTime(2024, 2, 4, 11, 10),
            content: "それは楽しそうですね！",
            type: MessageType.assistant),
        MessageEntity(
            id: "2024_2_4_8",
            createdAt: DateTime(2024, 2, 4, 11, 20),
            content: "はい！",
            type: MessageType.user),
      ];

      final messsage = [
        MessageEntity(
            id: "2024_2_10_1",
            createdAt: DateTime(2024, 2, 10, 11, 30),
            content: "😁",
            type: MessageType.user)
      ];

      // APIにリクエストを送信し、応答を取得
      String response;
      try {
        response = await repository.sendAndReceiveLLMMessage(
            messsage, "2024_2_10", EmotionType.joyful);
      } catch (e) {
        fail('API connection failed: $e');
      }
      // 応答を検証
      expect(response.isNotEmpty, true);
    });
  });
}
