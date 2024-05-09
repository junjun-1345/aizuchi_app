import 'package:aizuchi_app/domain/entity/enums/emotion.dart';
import 'package:aizuchi_app/domain/entity/enums/message.dart';
import 'package:aizuchi_app/domain/entity/models/message.dart';
import 'package:aizuchi_app/domain/interactor/messages_interactor.dart';
import 'package:aizuchi_app/infrastructure/repositories/claude_repository_impl.dart';
import 'package:aizuchi_app/infrastructure/repositories/gpt_repository_impl.dart';
import 'package:aizuchi_app/infrastructure/repositories/message_db_repositories_impl.dart';
import 'package:aizuchi_app/infrastructure/repositories/gemini_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Claude API Connection Test', () {
    // リポジトリのインスタンスを作成
    final geminiRepository = GenimiRepositoryImpl();
    final messageDBRepository = MessageDBRepositoryImpl();
    final gptRepository = GptRepositoryImpl();
    final claudeRepository = ClaudeRepositoryImpl();

    final messageUsecase = MessagesInteractor(
      messageDBRepository,
      geminiRepository,
      gptRepository,
      claudeRepository,
    );

    final messsages = [
      MessageEntity(
        id: "1",
        content: "😃",
        createdAt: DateTime.now(),
        type: MessageType.emotion,
      ),
      MessageEntity(
        id: "2",
        content: "それは良かった！😀今日の出来事を教えてほしい",
        createdAt: DateTime.now().add(const Duration(minutes: 1)),
        type: MessageType.assistant,
      ),
      MessageEntity(
        id: "3",
        content: "たくさん作業が進んだよ！",
        createdAt: DateTime.now().add(const Duration(minutes: 2)),
        type: MessageType.user,
      ),
      MessageEntity(
        id: "4",
        content: "へぇ～すごいじゃん！頑張ったんだね🥳作業って具体的に何をしたの？詳しく聞かせて！",
        createdAt: DateTime.now().add(const Duration(minutes: 3)),
        type: MessageType.assistant,
      ),
    ];

    test(
      'Create summary method should connect to API and get a response',
      () async {
        // APIにリクエストを送信し、応答を取得
        String response;
        try {
          response =
              await messageUsecase.createSummary(messsages, EmotionType.joyful);
        } catch (e) {
          fail('API connection failed: $e');
        }
        // 応答を検証
        expect(response.isNotEmpty, true);
      },
    );

    test(
      'Reply method should connect to API and get a response',
      () async {
        // APIにリクエストを送信し、応答を取得
        String response;
        try {
          response =
              await claudeRepository.reply(messsages, EmotionType.joyful);
        } catch (e) {
          fail('API connection failed: $e');
        }
        // 応答を検証
        expect(response.isNotEmpty, true);
      },
    );
  });
}
