import 'package:aizuchi_app/domain/entity/enums/sex.dart';
import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:aizuchi_app/presentation/state/user_providers.dart';
import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:aizuchi_app/presentation/view/pages/start/components/sign_up_form_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class SignUpFormSexPage extends HookConsumerWidget {
  const SignUpFormSexPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final choiceIndex = useState(SexEnum.unknown);
    final sexNotifier = ref.watch(userSexProvider.notifier);
    final errorState = useState("");
    return GestureDetector(
      onTap: () => choiceIndex.value = SexEnum.unknown,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const SignUpFormWidget(index: 2, content: "性別"),
                    for (int i = 1; i < 4; i++) ...{
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            choiceIndex.value = SexEnum.values[i];
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                choiceIndex.value == SexEnum.values[i]
                                    ? BrandColor.baseRed
                                    : Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            SexEnum.values[i].sexValue ?? "",
                            style: TextStyle(
                              color: choiceIndex.value == SexEnum.values[i]
                                  ? BrandColor.white
                                  : BrandColor.black,
                            ),
                          ),
                        ),
                      ),
                    },
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
                        context.router.maybePop(
                          const SignUpFormNameRoute(),
                        );
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                    IconButton(
                      onPressed: () {
                        if (choiceIndex.value == SexEnum.unknown) {
                          errorState.value = "性別を回答してください";
                        } else {
                          errorState.value = "";
                          sexNotifier.state = choiceIndex.value;
                          context.router.push(
                            const SignUpFormBirthDateRoute(),
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
