import 'package:aizuchi_app/domain/entity/enums/sex.dart';
import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:aizuchi_app/presentation/state/user_providers.dart';
import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:aizuchi_app/presentation/view/components/app_button.dart';
import 'package:aizuchi_app/presentation/view/pages/start/components/text_widget.dart';
import 'package:aizuchi_app/presentation/view_model/users_view_model.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class SignUpFormCheckPage extends HookConsumerWidget {
  const SignUpFormCheckPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userViewModel = ref.read(userViewModelProvider);
    final usersState = ref.watch(userProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    textTitleWidget("プロフィール"),
                    const SizedBox(
                      height: 48,
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text("この情報で、プロフィールを登録します。🐑"),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 120,
                          child: Image.asset('assets/images/moufu_icon_5.png'),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 56,
                    ),
                    Container(
                      height: 48,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        usersState.name,
                        style: const TextStyle(
                          color: BrandColor.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: 48,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        usersState.sex.sexValue ?? "未登録",
                        style: const TextStyle(
                          color: BrandColor.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: 48,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "${usersState.birthday.year}年 ${usersState.birthday.month}月 ${usersState.birthday.day}日",
                        style: const TextStyle(
                          color: BrandColor.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: 48,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        usersState.profession,
                        style: const TextStyle(
                          color: BrandColor.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () {
                        userViewModel.signOut();
                        context.router.maybePop(
                          const SignUpRoute(),
                        );
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                    AppButton.mediumInherit(
                      width: 160,
                      onPressed: () {
                        try {
                          userViewModel.register(context);
                        } catch (e) {
                          rethrow;
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: BrandColor.baseRed,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      text: "登録する",
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
