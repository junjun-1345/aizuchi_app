import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:aizuchi_app/presentation/view/components/app_button.dart';
import 'package:aizuchi_app/presentation/view_model/message_view_model.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MessageOverLimitDialog extends ConsumerWidget {
  const MessageOverLimitDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Text('会話の上限に達しました。'),
      backgroundColor: BrandColor.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('もっとお話できるプランを見る'),
          const SizedBox(height: 8),
          AppButton.medium(
            onPressed: () {
              context.router.push(const PurchaseRoute());
            },
            text: 'Aizuchi Premium >',
          ),
          const SizedBox(height: 24),
          const Text('会話を終了しますか？'),
          const SizedBox(height: 8),
          AppButton.medium(
            onPressed: () {
              Navigator.of(context).pop();
              ref.read(messageViewModelProvider).createSummary();
            },
            text: '終了',
          ),
        ],
      ),
    );
  }
}
