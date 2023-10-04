import 'package:aizuchi_app/application/di/usecase.dart';
import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:aizuchi_app/presentation/widgets/button_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignInPage extends HookConsumerWidget {
  const SignInPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final _isObscure = useState(true);
    final _errorMessage = useState("");
    final _formKey = useMemoized(GlobalKey<FormState>.new);
    final _emailAddressController = useTextEditingController();
    final _passwordController = useTextEditingController();

    final signInButton = RegisterButton(
      onPressed: () {
        _formKey.currentState!.validate();
        final usecase = ref.read(accountUsecaseProvider);
        usecase.signInEmailValidation(
          emailAddress: _emailAddressController.text,
          password: _passwordController.text,
          onError: (String e) {
            print("エラー:$e");
            _errorMessage.value = e;
            return;
          },
          onSuccess: () {
            print("PagePath.singUpInfo");
            context.go(PagePath.chat);
          },
        );
      },
      text: 'サインイン',
    );

    final signInWithGoogleButton = MaterialButton(
      padding: EdgeInsets.all(8.0),
      textColor: Colors.black,
      elevation: 8.0,
      child: Container(
        child: Image.asset(
            'assets/images/btn_google_signin_light_normal_web@2x.png'),
      ),
      onPressed: () {
        final usecase = ref.read(accountUsecaseProvider);
        usecase.signInGoogleValidation(
          onError: (String e) {
            print("エラー:$e");
            _errorMessage.value = e;
            return;
          },
          onSuccess: () {
            print("PagePath.singUpInfo");
            context.go(PagePath.chat);
          },
        );
      },
    );

    Widget emailTextform(String hintText) {
      return TextFormField(
        controller: _emailAddressController,
        decoration: InputDecoration(
          hintText: hintText,
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
            borderSide: BorderSide(
              color: Colors.black12,
              width: 1.0,
            ),
          ),
        ),
        validator: (value) {
          if (value == null || !EmailValidator.validate(value)) {
            return '正しい形式でメールアドレスを入力してください';
          }
          return null;
        },
      );
    }

    Widget passwordTextform(String hintText) {
      return TextFormField(
        controller: _passwordController,
        obscureText: _isObscure.value,
        decoration: InputDecoration(
          hintText: hintText,
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
            borderSide: BorderSide(
              color: Colors.black12,
              width: 1.0,
            ),
          ),
          suffixIcon: IconButton(
            icon: Icon(
                _isObscure.value ? Icons.visibility_off : Icons.visibility),
            onPressed: () {
              _isObscure.value = !_isObscure.value;
            },
          ),
        ),
        validator: (value) => value!.isEmpty ? '文字を入力してください。' : null,
      );
    }

    //////////////////////
    // レイアウトの構成
    //////////////////////
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          color: Colors.white,
          onPressed: () {
            context.go(PagePath.start);
          },
        ),
        title: Text("サインイン"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: SizedBox(
          width: screenWidth * 0.8,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                emailTextform("メールアドレスを入力"),
                const SizedBox(
                  height: 16,
                ),
                passwordTextform("パスワードを入力"),
                const SizedBox(
                  height: 24,
                ),
                signInButton,
                Text(
                  _errorMessage.value,
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                signInWithGoogleButton,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
