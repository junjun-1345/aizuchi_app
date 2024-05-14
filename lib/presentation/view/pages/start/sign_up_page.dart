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
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class SignUpPage extends HookConsumerWidget {
  const SignUpPage({super.key});

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
    final Uri urlTerm = Uri.parse('https://aizuchi.app/terms');
    final Uri urlPrivacyPolicy = Uri.parse('https://aizuchi.app/privacypolicy');

    Widget descriptionText() {
      return RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.black, fontSize: 16.0),
          children: [
            TextSpan(
              text: '利用規約',
              style: const TextStyle(
                  color: BrandColor.baseRed, fontWeight: FontWeight.bold),
              recognizer: TapGestureRecognizer()
                ..onTap = () => context.router.push(WebViewRoute(uri: urlTerm)),
            ),
            const TextSpan(text: 'と'),
            TextSpan(
              text: 'プライバシーポリシー',
              style: const TextStyle(
                  color: BrandColor.baseRed, fontWeight: FontWeight.bold),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  context.router.push(WebViewRoute(uri: urlPrivacyPolicy));
                },
            ),
            const TextSpan(text: 'を同意の上、ご登録ください'),
          ],
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                      const SizedBox(
                        height: 64,
                      ),
                      textTitleWidget("アカウント登録"),
                      const SizedBox(
                        height: 32,
                      ),
                      descriptionText(),
                      const SizedBox(
                        height: 16,
                      ),
                      AppButton.google(
                        text: "Googleで登録",
                        onPressed: () async {
                          await userViewModel.signUpWith(
                              platform: PlatformType.google,
                              onSuccess: () {
                                router.push(const SignUpFormNameRoute());
                              });
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      AppButton.apple(
                        text: "Appleで登録",
                        onPressed: () async {
                          await userViewModel.signUpWith(
                              platform: PlatformType.apple,
                              onSuccess: () {
                                router.push(const SignUpFormNameRoute());
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
                      AppTextForm.password(passwordController,
                          obscureText: isObscure.value, onPressed: () {
                        isObscure.value = !isObscure.value;
                      }),
                      AppButton.medium(
                        text: "Aizuchiに登録",
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            userEmailState.state = emailController.text;
                            userPasswordState.state = passwordController.text;
                            await userViewModel.signUpWith(
                              platform: PlatformType.email,
                              onSuccess: () {
                                router.push(
                                  const SignUpFormNameRoute(),
                                );
                              },
                            );
                          }
                        },
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
                          context.router.replace(const SignInRoute());
                        },
                        child: const Text(
                          "アカウントを既にお持ちの方はこちら",
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
      ),
    );
  }
}
