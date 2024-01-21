import 'package:aizuchi_app/domain/entity/model/color.dart';
import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:aizuchi_app/presentation/view/widget/sign_up_form_widget.dart';
import 'package:aizuchi_app/presentation/view_model/user_view_model.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class SignUpFormSurveyPage extends HookConsumerWidget {
  const SignUpFormSurveyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final choiceProfession = useState("");
    final professionList = [
      "会社員・公務員",
      "経営者・役員",
      "自営業・フリーランス",
      "パート・アルバイト",
      "専業主婦・主夫",
      "無職・休職中",
      "学生",
      "医療関係者",
      "士業",
      "その他",
    ];
    final professionNotifier = ref.watch(professionProvider.notifier);
    return GestureDetector(
      onTap: () => choiceProfession.value = "",
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const SignUpFormWidget(index: 4, content: "職業"),
                      for (int i = 0; i < professionList.length; i++) ...{
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              choiceProfession.value = professionList[i];
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  choiceProfession.value == professionList[i]
                                      ? BrandColor.baseRed
                                      : Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              professionList[i],
                              style: TextStyle(
                                color:
                                    choiceProfession.value == professionList[i]
                                        ? BrandColor.white
                                        : BrandColor.black,
                              ),
                            ),
                          ),
                        )
                      }
                    ],
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: () {
                          context.router.pop(const SignUpFormBirthDateRoute());
                        },
                        icon: const Icon(Icons.arrow_back),
                      ),
                      SizedBox(
                        width: 120,
                        child: ElevatedButton(
                          onPressed: () {
                            context.router.push(
                              const SignUpFormCheckRoute(),
                            );
                            professionNotifier.state = choiceProfession.value;
                            print("push");
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: BrandColor.baseRed,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: const Text("確認する"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
