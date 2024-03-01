import 'package:aizuchi_app/domain/entity/enums/platform.dart';
import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:aizuchi_app/presentation/state/user_state.dart';
import 'package:aizuchi_app/presentation/state/user_providers.dart';
import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:aizuchi_app/presentation/view/widget/text_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sign_in_button/sign_in_button.dart';

@RoutePage()
class SignInPage extends HookConsumerWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(usersNotifierProvider.notifier);
    final userEmailState = ref.watch(userEmailProvider.notifier);
    final userPasswordState = ref.watch(passwordProvider.notifier);
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final isObscure = useState(true);
    final errorMessage = useState("");

    final router = context.router;

    //TODO: 2024/01/19　サインインボタンの機能関係実装

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
            try {
              final result = await notifier.signInWith(PlatformType.google);
              if (result) {
                router.push(const MessageRoute());
              } else {
                errorMessage.value = "アカウントがまだ登録されていません";
              }
            } on FirebaseAuthException catch (e) {
              print("UI firebaseエラー${e.toString()}");
              // errorMessage.value = e.toString();
            } catch (e) {
              errorMessage.value = "エラーが発生しました。もう一度お試しください。";
              print("UIエラー${e.toString()}");
              errorMessage.value = e.toString();
            }
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
            try {
              final result = await notifier.signInWith(PlatformType.email);
              if (result) {
                router.push(const MessageRoute());
              } else {
                errorMessage.value = "アカウントがまだ登録されていません";
              }
            } catch (e) {
              errorMessage.value = "エラーが発生しました。もう一度お試しください。";
              print(e.toString());
            }
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

    Widget emailTextform() {
      return SizedBox(
        height: 80,
        child: TextFormField(
          controller: emailController,
          validator: (value) {
            if (value == null || !EmailValidator.validate(value)) {
              return '正しい形式でメールアドレスを入力してください';
            }
            return null;
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            hintText: "メールアドレスを入力",
            hintStyle: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
            fillColor: Colors.white,
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Colors.black54,
                width: 2.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Colors.black12,
                width: 1.0,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1.0,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 2.0,
              ),
            ),
          ),
        ),
      );
    }

    Widget passwordTextform() {
      return SizedBox(
        height: 80,
        child: TextFormField(
          controller: passwordController,
          obscureText: isObscure.value,
          validator: (value) {
            if (value!.isEmpty) {
              return 'パスワードを入力してください';
            }
            return null;
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            hintText: "パスワードを入力",
            hintStyle: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
            fillColor: Colors.white,
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Colors.black54,
                width: 2.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Colors.black12,
                width: 1.0,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1.0,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 2.0,
              ),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                  isObscure.value ? Icons.visibility_off : Icons.visibility),
              color: BrandColor.baseRed,
              onPressed: () {
                isObscure.value = !isObscure.value;
              },
            ),
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
                  emailTextform(),
                  passwordTextform(),
                  registerButton(),
                  Text(
                    errorMessage.value,
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
