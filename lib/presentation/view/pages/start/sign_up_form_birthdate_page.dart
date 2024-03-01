import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:aizuchi_app/presentation/state/user_providers.dart';
import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:aizuchi_app/presentation/view/pages/start/components/sign_up_form_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class SignUpFormBirthDatePage extends HookConsumerWidget {
  const SignUpFormBirthDatePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final birthDate = useState(DateTime(0));
    final birthdayNotifier = ref.watch(userBirthdayProvider.notifier);
    final errorState = useState("");
    return GestureDetector(
      onTap: () => birthDate.value = DateTime(0),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const SignUpFormWidget(
                      index: 3,
                      content: "生年月日",
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              minTime: DateTime(1900, 1, 1),
                              maxTime: DateTime.now(), onConfirm: (date) {
                            birthDate.value = date;
                            errorState.value = "";
                          },
                              currentTime: DateTime(2000, 1, 1),
                              locale: LocaleType.jp);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          birthDate.value == DateTime(0)
                              ? "生年月日を入力"
                              : "${birthDate.value.year}年 ${birthDate.value.month}月 ${birthDate.value.day}日",
                          style: const TextStyle(
                            color: BrandColor.black,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      errorState.value,
                      style: const TextStyle(color: Colors.red, fontSize: 10),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () {
                        context.router.pop(
                          const SignUpFormSexRoute(),
                        );
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                    IconButton(
                      onPressed: () {
                        if (birthDate.value == DateTime(0)) {
                          errorState.value = "生年月日を入力してください";
                        } else {
                          birthdayNotifier.state = birthDate.value;
                          context.router.push(
                            const SignUpFormSurveyRoute(),
                          );
                        }
                      },
                      icon: const Icon(Icons.arrow_forward),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
