import 'package:aizuchi_app/domain/entity/enums/platform.dart';
import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:aizuchi_app/presentation/state/app_state.dart';
import 'package:aizuchi_app/presentation/state/user_providers.dart';
import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:aizuchi_app/presentation/view/components/app_button.dart';
import 'package:aizuchi_app/presentation/view/components/app_textform.dart';
import 'package:aizuchi_app/presentation/view/pages/start/components/start_divider.dart';
import 'package:aizuchi_app/presentation/view/pages/start/components/start_image.dart';
import 'package:aizuchi_app/presentation/view/pages/start/components/text_widget.dart';
import 'package:aizuchi_app/presentation/view_model/users_view_model.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class SignInPage extends HookConsumerWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserViewModel userViewModel = ref.read(userViewModelProvider);
    final StateController<String?> userEmailState =
        ref.watch(userEmailProvider.notifier);
    final StateController<String> userPasswordState =
        ref.watch(passwordProvider.notifier);
    final TextEditingController emailController = useTextEditingController();
    final TextEditingController passwordController = useTextEditingController();
    final GlobalKey<FormState> formKey = useMemoized(GlobalKey<FormState>.new);
    final ValueNotifier<bool> isObscure = useState(true);
    final String error = ref.watch(errorProvider);
    final StackRouter router = context.router;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Container(
            // color: BrandColor.base,
            alignment: Alignment.center,
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    textTitleWidget("アカウントログイン"),
                    const SizedBox(
                      height: 32,
                    ),
                    AppButton.google(
                      text: "Googleでログイン",
                      onPressed: () async {
                        await userViewModel.signInWith(
                            platform: PlatformType.google,
                            onSuccess: () {
                              router.push(const MessageRoute());
                            });
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    AppButton.apple(
                      text: "Appleでログイン",
                      onPressed: () async {
                        await userViewModel.signInWith(
                            platform: PlatformType.apple,
                            onSuccess: () {
                              router.push(const MessageRoute());
                            });
                      },
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    const StartDivider(),
                    const SizedBox(
                      height: 40,
                    ),
                    AppTextForm.email(emailController),
                    AppTextForm.password(
                      passwordController,
                      obscureText: isObscure.value,
                      onPressed: () {
                        isObscure.value = !isObscure.value;
                      },
                    ),
                    AppButton.medium(
                      text: "Aizuchiにログイン",
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          userEmailState.state = emailController.text;
                          userPasswordState.state = passwordController.text;
                          await userViewModel.signInWith(
                            platform: PlatformType.email,
                            onSuccess: () {
                              router.push(
                                const MessageRoute(),
                              );
                            },
                          );
                        }
                      },
                    ),
                    TextButton(
                      onPressed: () {
                        context.router.replace(const PasswordChangeRoute());
                      },
                      child: const Text(
                        "パスワードを忘れた方はこちら",
                        style: TextStyle(
                          color: BrandColor.baseRed,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        ref.read(errorProvider.notifier).state = "";
                      },
                      child: Text(
                        error,
                        style: const TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context.router.replace(const SignUpRoute());
                      },
                      child: const Text(
                        "まだアカウントをお持ちでない方はこちら",
                        style: TextStyle(
                          color: BrandColor.baseRed,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const StartImage(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
