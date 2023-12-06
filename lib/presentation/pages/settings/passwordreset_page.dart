import 'package:aizuchi_app/presentation/dialog/customDialog_widget.dart';
import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:aizuchi_app/presentation/widgets/button_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PasswordResetPage extends HookConsumerWidget {
  const PasswordResetPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final _errorMessage = useState("");
    final _formKey = useMemoized(GlobalKey<FormState>.new);
    final _emailAddressController = useTextEditingController();

    final sendButton = RegisterButton(
      onPressed: () async {
        _formKey.currentState!.validate();
        try {
          await FirebaseAuth.instance
              .sendPasswordResetEmail(email: _emailAddressController.text);
          CustomDialogWidget(
              message: "パスワードリセット用のメールを送信しました", routeName: PagePath.start);
        } catch (e) {
          print(e);
        }
      },
      text: 'メールを送信',
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
        title: Text("パスワードリセット"),
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
                sendButton,
                Text(
                  _errorMessage.value,
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
