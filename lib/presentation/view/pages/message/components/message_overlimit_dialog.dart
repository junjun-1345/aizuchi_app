import 'package:aizuchi_app/presentation/view_model/message_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MessageOverLimitDialog extends ConsumerWidget {
  const MessageOverLimitDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Text('会話の上限に達しました。'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('もっとお話できるプランを見る'),
          // Aizuchi Premiumボタン
          ElevatedButton(
            onPressed: () {
              // Aizuchi Premiumの詳細画面に遷移するロジック
            },
            child: const Text('Aizuchi Premium >'),
          ),
          const SizedBox(height: 16),
          const Text('会話を終了しますか？'),
          // 終了ボタン
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ref.read(messageViewModelProvider).createSummary();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink, // ボタンの背景色
            ),
            child: const Text('終了'),
          ),
        ],
      ),
    );
  }
}
