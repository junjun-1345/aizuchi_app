import 'dart:io';

import 'package:aizuchi_app/domain/entity/enums/update.dart';
import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:aizuchi_app/infrastructure/data_model.dart';
import 'package:aizuchi_app/infrastructure/enums/shared_preferences_key.dart';
import 'package:aizuchi_app/presentation/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class AppDialog {
  static void showAttentionDialog({
    required BuildContext context,
    required String title,
    required String content,
    required VoidCallback onPressed,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          backgroundColor: BrandColor.white,
          surfaceTintColor: Colors.transparent,
          actionsAlignment: MainAxisAlignment.spaceAround,
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('キャンセル',
                  style: TextStyle(color: BrandColor.baseRed)),
            ),
            TextButton(
              onPressed: onPressed,
              child:
                  const Text('OK', style: TextStyle(color: BrandColor.baseRed)),
            ),
          ],
        );
      },
    );
  }

  static void showCompletedDialog({
    required BuildContext context,
    required String title,
    required String content,
    required VoidCallback onPressed,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          backgroundColor: BrandColor.white,
          surfaceTintColor: Colors.transparent,
          actionsAlignment: MainAxisAlignment.spaceAround,
          actions: <Widget>[
            TextButton(
              onPressed: onPressed,
              child:
                  const Text('OK', style: TextStyle(color: BrandColor.baseRed)),
            ),
          ],
        );
      },
    );
  }

  static void showCheckDialog({
    required BuildContext context,
    required String title,
    required String content,
    required VoidCallback onCompleted,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          backgroundColor: BrandColor.white,
          surfaceTintColor: Colors.transparent,
          actionsAlignment: MainAxisAlignment.spaceAround,
          actions: <Widget>[
            TextButton(
              onPressed: onCompleted,
              child:
                  const Text('OK', style: TextStyle(color: BrandColor.baseRed)),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('キャンセル',
                  style: TextStyle(color: BrandColor.baseRed)),
            ),
          ],
        );
      },
    );
  }

  static void showErrorDialog({
    required BuildContext context,
    required String title,
    String? content,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return Consumer(
          builder: (context, ref, child) {
            final error = ref.watch(errorProvider);
            return AlertDialog(
              title: Text(title),
              content: Text(content ?? error),
              backgroundColor: BrandColor.white,
              surfaceTintColor: Colors.transparent,
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    ref.read(errorProvider.notifier).state = "";
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK',
                      style: TextStyle(color: BrandColor.baseRed)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  static void showUpdatePromptDialog({
    required BuildContext context,
    required UpdateRequestType? updateRequestType,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false, // ダイアログの外をタップしても閉じない
      builder: (context) {
        return Consumer(
          builder: (context, ref, child) {
            return AlertDialog(
              title: const Text('アプリが更新されました。\n\n最新バージョンのダウンロードをお願いします。'),
              actionsAlignment: MainAxisAlignment.center,
              surfaceTintColor: Colors.transparent,
              actions: [
                if (updateRequestType == UpdateRequestType.cancelable)
                  TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      await ref.read(sharedPreferencesRepositoryProvider).save(
                            SharedPreferencesKey.cancelledUpdateDateTime,
                            DateTime.now().toString(),
                          );
                      ref.invalidate(remoteConfigRepositoryProvider);
                    },
                    child: const Text('キャンセル',
                        style: TextStyle(color: BrandColor.baseRed)),
                  ),
                TextButton(
                  onPressed: () async {
                    String url;
                    if (Platform.isAndroid) {
                      url =
                          "https://play.google.com/store/apps/details?id=com.example.yourapp"; // TODO: Google PlayのURLを設定
                    } else if (Platform.isIOS) {
                      url =
                          "https://itunes.apple.com/jp/aizuchi/app/id6479214928";
                    } else {
                      throw ('Unsupported platform');
                    }
                    Uri uri = Uri.parse(url);
                    await launchUrl(uri);
                  },
                  child: const Text('アップデートする',
                      style: TextStyle(color: BrandColor.baseRed)),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
