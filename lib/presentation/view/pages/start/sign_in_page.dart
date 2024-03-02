import 'package:aizuchi_app/domain/entity/enums/platform.dart';
import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:aizuchi_app/presentation/state/app_state.dart';
import 'package:aizuchi_app/presentation/state/user_providers.dart';
import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:aizuchi_app/presentation/view/components/app_textform.dart';
import 'package:aizuchi_app/presentation/view/pages/start/components/text_widget.dart';
import 'package:aizuchi_app/presentation/view_model/users_view_model.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sign_in_button/sign_in_button.dart';

@RoutePage()
class SignInPage extends HookConsumerWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserViewModel userViewModel = ref.read(userViewModelProvider);
    final StateController<String> userEmailState =
        ref.watch(userEmailProvider.notifier);
    final StateController<String> userPasswordState =
        ref.watch(passwordProvider.notifier);
    final TextEditingController emailController = useTextEditingController();
    final TextEditingController passwordController = useTextEditingController();
    final GlobalKey<FormState> formKey = useMemoized(GlobalKey<FormState>.new);
    final ValueNotifier<bool> isObscure = useState(true);
    final String error = ref.watch(errorProvider);
    final StackRouter router = context.router;

    Widget singInWithGoogleButton() {
      return SizedBox(
        width: double.infinity,
        child: SignInButton(
          Buttons.google,
          padding: const EdgeInsets.fromLTRB(72, 0, 0, 0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          text: "Googleでログイン",
          onPressed: () async {
            await userViewModel.signInWith(
                platform: PlatformType.google,
                onSuccess: () {
                  router.push(const MessageRoute());
                });
          },
        ),
      );
    }

    Widget singInWithAppleButton() {
      return SizedBox(
        width: double.infinity,
        child: SignInButtonBuilder(
          text: 'Appleでログイン',
          padding: const EdgeInsets.fromLTRB(72, 0, 0, 0),
          icon: Icons.apple,
          onPressed: () {},
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
        ),
      );
    }

    Widget registerButton() {
      return SizedBox(
        height: 40,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () async {
            formKey.currentState!.validate();
            userEmailState.state = emailController.text;
            userPasswordState.state = passwordController.text;
            await userViewModel.signInWith(
                platform: PlatformType.email,
                onSuccess: () {
                  router.push(const MessageRoute());
                });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: BrandColor.baseRed,
            shape: const StadiumBorder(),
            elevation: 0,
          ),
          child: const Text(
            'Aizuchiにログイン',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
      );
    }

    Widget customDivider() {
      return const Row(
        children: [
          Expanded(
            child: Divider(
              color: Colors.black,
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            'または',
            style: TextStyle(
              color: BrandColor.baseRed,
              fontSize: 16,
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Divider(
              color: Colors.black,
            ),
          ),
        ],
      );
    }

    Widget reverseButton() {
      return TextButton(
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
      );
    }

    Widget imageWidget() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: 88,
            width: 88,
            child: Image.asset('assets/images/mofumofu_icon_1.png'),
          ),
        ],
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Container(
            // color: BrandColor.base,
            alignment: Alignment.center,
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  textTitleWidget("アカウントログイン"),
                  const SizedBox(
                    height: 32,
                  ),
                  singInWithGoogleButton(),
                  const SizedBox(
                    height: 8,
                  ),
                  singInWithAppleButton(),
                  const SizedBox(
                    height: 32,
                  ),
                  customDivider(),
                  const SizedBox(
                    height: 40,
                  ),
                  AppTextForm.email(emailController),
                  AppTextForm.password(passwordController,
                      obscureText: isObscure.value, onPressed: () {
                    isObscure.value = !isObscure.value;
                  }),
                  registerButton(),
                  Text(
                    error,
                    style: const TextStyle(
                      color: Colors.red,
                    ),
                  ),
                  reverseButton(),
                  imageWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
