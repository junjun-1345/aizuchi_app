import 'package:aizuchi_app/application/di/usecase.dart';
import 'package:aizuchi_app/application/state/appuser.dart';
import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:aizuchi_app/presentation/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/button_widget.dart';

class SignUpCheckPage extends ConsumerWidget {
  const SignUpCheckPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.read(appUserNotifierProvider);
    final usecase = ref.read(accountUsecaseProvider);

    final regidterButton = Expanded(
      child: Button(
        onPressed: () {
          debugPrint("ボタン押下");
          context.go(PagePath.chat);
          usecase.createAccount();
        },
        text: '登録',
      ),
    );

    final prevPageButton = SizedBox(
      width: 96,
      child: Button(
        onPressed: () {
          context.go(PagePath.singupBirthDay);
        },
        text: '戻る',
      ),
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          '登録内容をチェック',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${state.name}",
                style: BrandText.textL,
              ),
              Text(
                "${state.sex}",
                style: BrandText.textL,
              ),
              Text(
                "${state.birhtDay}",
                style: BrandText.textL,
              ),
              Row(
                children: [
                  prevPageButton,
                  const SizedBox(width: 16.0),
                  regidterButton,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
