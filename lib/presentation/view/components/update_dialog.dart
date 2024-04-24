import 'dart:io';

import 'package:aizuchi_app/domain/entity/enums/shared_preferences_key.dart';
import 'package:aizuchi_app/domain/entity/enums/update.dart';
import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:aizuchi_app/infrastructure/data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdatePromptDialog extends ConsumerWidget {
  const UpdatePromptDialog({
    super.key,
    required this.updateRequestType,
  });

  final UpdateRequestType? updateRequestType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopScope(
      // AndroidのBackボタンで閉じられないようにする
      onPopInvoked: (flag) => false,
      canPop: false,
      child: AlertDialog(
        title: const Text('アプリが更新されました。\n\n最新バージョンのダウンロードをお願いします。'),
        actionsAlignment: MainAxisAlignment.center,
        surfaceTintColor: Colors.transparent,
        actions: [
          if (updateRequestType == UpdateRequestType.cancelable)
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                await ref.read(sharedPreferencesProvider).save(
                      SharedPreferencesKey.cancelledUpdateDateTime,
                      DateTime.now().toString(),
                    );
                ref.invalidate(remoteConfigProvider);
              },
              child: const Text('キャンセル',
                  style: TextStyle(color: BrandColor.baseRed)),
            ),
          TextButton(
            onPressed: () async {
              String url;
              // プラットフォームごとにURLを切り替え
              if (Platform.isAndroid) {
                // TODO: Google PlayのURLを設定
                url = "";
              } else if (Platform.isIOS) {
                url = "https://itunes.apple.com/jp/aizuchi/app/id6479214928";
              } else {
                // サポートされていないプラットフォームの場合
                throw ('Unsupported platform');
              }
              Uri uri = Uri(path: url);
              await launchUrl(uri);
            },
            child: const Text('アップデートする',
                style: TextStyle(color: BrandColor.baseRed)),
          ),
        ],
      ),
    );
  }
}
