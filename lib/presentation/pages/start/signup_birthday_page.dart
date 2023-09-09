import 'package:aizuchi_app/application/state/appuser.dart';
import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:aizuchi_app/presentation/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../widgets/button_widget.dart';

class SignUpBirthdayPage extends HookConsumerWidget {
  const SignUpBirthdayPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final birthdayState = useState(DateTime(1900));

    final state = ref.watch(appUserNotifierProvider);
    final notifier = ref.read(appUserNotifierProvider.notifier);

    final textField = Button(
      onPressed: () async {
        final selectedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2200),
        );
        birthdayState.value = selectedDate!;
      },
      text: '生年月日を選択',
    );

    final nextPageButton = Expanded(
      child: Button(
        onPressed: () {
          notifier
              .update(state.copyWith(birhtDay: birthdayState.value.toString()));
          context.go(PagePath.singupCheck);
        },
        text: '次へ',
      ),
    );

    final prevPageButton = SizedBox(
      width: 96,
      child: Button(
        onPressed: () {
          context.go(PagePath.singupSex);
        },
        text: '戻る',
      ),
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          '生年月日',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("生年月日を入力", style: BrandText.textL),
              const SizedBox(height: 16),
              Text(
                  "${birthdayState.value.year}/${birthdayState.value.month}/${birthdayState.value.day}",
                  style: BrandText.textButton),
              const SizedBox(height: 16),
              textField,
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
