import 'package:aizuchi_app/application/di/usecase.dart';
import 'package:aizuchi_app/application/state/appuser.dart';
import 'package:aizuchi_app/domain/features/datetime.dart';

import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:aizuchi_app/presentation/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../widgets/button_widget.dart';

class SignUpNamePage extends HookConsumerWidget {
  const SignUpNamePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(appUserNotifierProvider.notifier);
    final state = ref.read(appUserNotifierProvider);
    final usecase = ref.read(accountUsecaseProvider);

    final nameController =
        TextEditingController(text: state.name.isEmpty ? state.name : "");

    final textField = TextField(
      autofocus: true,
      controller: nameController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        hintText: 'ここに入力',
      ),
    );

    final nextPageButton = Expanded(
      child: Button(
        onPressed: () {
          notifier.update(
            state.copyWith(
              name: nameController.text,
              registerDay: CustomDateTime().nowDate().toString(),
            ),
          );
          context.go(PagePath.singupSex);
        },
        text: '次へ',
      ),
    );

    final prevPageButton = SizedBox(
      width: 96,
      child: Button(
        onPressed: () {
          usecase.signOut();
          context.go(PagePath.start);
        },
        text: '戻る',
      ),
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          '新規登録',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("ニックネームを入力してください", style: BrandText.textL),
              const SizedBox(height: 16),
              textField,
              const SizedBox(height: 16),
              Row(
                children: [
                  prevPageButton,
                  const SizedBox(width: 16.0),
                  nextPageButton
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
