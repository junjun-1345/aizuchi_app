import 'package:aizuchi_app/application/state/appuser.dart';
import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:aizuchi_app/presentation/theme/colors.dart';
import 'package:aizuchi_app/presentation/theme/fonts.dart';
import 'package:aizuchi_app/presentation/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignUpSexPage extends HookConsumerWidget {
  const SignUpSexPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.read(appUserNotifierProvider);
    final notifier = ref.read(appUserNotifierProvider.notifier);
    final choiceIndex = useState(0);

    final nullButton = SizedBox(
      child: ChoiceChip(
        label: Text("無回答"),
        selected: choiceIndex.value == 0,
        backgroundColor: Colors.grey[600],
        selectedColor: Colors.white,
        onSelected: (_) {
          choiceIndex.value = 0;
        },
      ),
    );

    final menButton = ChoiceChip(
      label: Text("男性"),
      selected: choiceIndex.value == 1,
      backgroundColor: Colors.grey[600],
      selectedColor: BrandColor.baseBlue,
      onSelected: (_) {
        choiceIndex.value = 1;
      },
    );

    final womenButton = ChoiceChip(
      label: Text("女性"),
      selected: choiceIndex.value == 2,
      backgroundColor: Colors.grey[600],
      selectedColor: BrandColor.baseRed,
      onSelected: (_) {
        choiceIndex.value = 2;
      },
    );

    final nextPageButton = Expanded(
      child: Button(
        onPressed: () {
          notifier.update(state.copyWith(sex: choiceIndex.value));
          context.go(PagePath.singupBirthDay);
        },
        text: '次へ',
      ),
    );

    final prevPageButton = SizedBox(
      width: 96,
      child: Button(
        onPressed: () {
          context.go(PagePath.singupName);
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
              const Text("性別を入力してください", style: BrandText.textL),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  nullButton,
                  menButton,
                  womenButton,
                ],
              ),
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
