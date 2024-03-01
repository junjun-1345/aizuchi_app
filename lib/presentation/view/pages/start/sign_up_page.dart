import 'package:aizuchi_app/domain/entity/enums/platform.dart';
import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:aizuchi_app/presentation/state/user_state.dart';
import 'package:aizuchi_app/presentation/state/user_providers.dart';
import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:aizuchi_app/presentation/view/widget/text_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sign_in_button/sign_in_button.dart';

@RoutePage()
class SignUpPage extends HookConsumerWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(usersNotifierProvider.notifier);
    final userEmailState = ref.watch(userEmailProvider.notifier);
    final userPasswordState = ref.watch(passwordProvider.notifier);
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final errorMessage = useState("");

    final formKey = useMemoized(GlobalKey<FormState>.new);
    final isObscure = useState(true);

    final router = context.router;

    Widget singUpWithGoogleButton() {
      return SizedBox(
        width: double.infinity,
        child: SignInButton(
          Buttons.google,
          padding: const EdgeInsets.fromLTRB(72, 0, 0, 0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          text: "Googleで登録",
          onPressed: () async {
            try {
              final result = await notifier.signUpWith(PlatformType.google);
              if (result) {
                router.push(const SignUpFormNameRoute());
              } else {
                errorMessage.value = "アカウントが既に登録されています";
              }
            } catch (e) {
              errorMessage.value = "エラーが発生しました。もう一度お試しください。";
              print(e.toString());
              // errorMessage.value = e.toString();
            }
          },
        ),
      );
    }

    Widget singUpWithAppleButton() {
      return SizedBox(
        width: double.infinity,
        child: SignInButtonBuilder(
          text: 'Appleで登録',
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
              final result = await notifier.signUpWith(PlatformType.email);
              if (result) {
                router.push(const SignUpFormNameRoute());
              } else {
                errorMessage.value = "アカウントが既に登録されています";
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
            'Aizuchiに登録',
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
          context.router.replace(const SignInRoute());
        },
        child: const Text(
          "アカウントを既にお持ちの方はこちら",
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
            height: 100,
            width: 100,
            child: Image.asset('assets/images/mofumofu_icon_1.png'),
          ),
        ],
      );
    }

    Widget descriptionText() {
      return RichText(
        text: TextSpan(
          style: const TextStyle(
              color: Colors.black, fontSize: 16.0), // デフォルトのスタイル
          children: [
            TextSpan(
              text: '利用規約',
              style: const TextStyle(
                  color: BrandColor.baseRed, fontWeight: FontWeight.bold),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  // ボタンがタップされた時のアクション
                },
            ),
            const TextSpan(text: 'と'),
            TextSpan(
              text: 'プライバシーポリシー',
              style: const TextStyle(
                  color: BrandColor.baseRed, fontWeight: FontWeight.bold),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  // ボタンがタップされた時のアクション
                },
            ),
            const TextSpan(text: 'を同意の上、ご登録ください'),
          ],
        ),
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
                  textTitleWidget("アカウント登録"),
                  const SizedBox(
                    height: 32,
                  ),
                  descriptionText(),
                  const SizedBox(
                    height: 16,
                  ),
                  singUpWithGoogleButton(),
                  const SizedBox(
                    height: 8,
                  ),
                  singUpWithAppleButton(),
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
                    // "エラー",
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
