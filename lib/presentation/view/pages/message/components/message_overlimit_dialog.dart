import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:aizuchi_app/presentation/view/components/app_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MessageOverLimitDialog extends ConsumerWidget {
  const MessageOverLimitDialog({required this.onFunction, super.key});

  final VoidCallback onFunction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Text('会話の上限に達しました。'),
      backgroundColor: BrandColor.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // FIXME: 課金機能解除後にコメントアウトを外す
          // const Text('もっとお話できるプランを見る'),
          // const SizedBox(height: 8),
          // AppButton.medium(
          //   onPressed: () {
          //     context.router.push(const PurchaseRoute());
          //   },
          //   text: 'Aizuchi Premium >',
          // ),
          // FIXME: 課金機能解除後に以下一行削除
          const Text('会話制限に達してしまいました...'),
          const SizedBox(height: 24),
          const Text('会話を終了しますか？'),
          const SizedBox(height: 8),
          AppButton.medium(
            onPressed: () {
              onFunction();
              Navigator.of(context).pop();
            },
            text: '終了',
          ),
        ],
      ),
    );
  }
}
