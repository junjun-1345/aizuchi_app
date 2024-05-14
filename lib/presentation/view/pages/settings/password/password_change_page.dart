import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:aizuchi_app/presentation/view/components/app_button.dart';
import 'package:aizuchi_app/presentation/view/components/app_textform.dart';
import 'package:aizuchi_app/presentation/view_model/users_view_model.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class PasswordChangePage extends HookConsumerWidget {
  const PasswordChangePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userViewModel = ref.read(userViewModelProvider);
    final emailController = useTextEditingController();
    final formKey = useMemoized(GlobalKey<FormState>.new);

    return Scaffold(
      appBar: AppBar(
        title: const Text("パスワード変更", style: TextStyle(color: BrandColor.black)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: BrandColor.textBlack),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 48),
                AppTextForm.email(
                  emailController,
                  hintText: "パスワード設定用メールの送信先を入力",
                ),
                AppButton.medium(
                    text: "パスワードを変更",
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        _showConfirmationDialog(
                            context, ref, userViewModel, emailController.text);
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handlePasswordChange(
    BuildContext context,
    WidgetRef ref,
    UserViewModel userViewModel,
    String email,
  ) {
    userViewModel.updatePassword(
      email: email,
      onSuccess: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("新しいパスワードでログインしてください。"),
          ),
        );
        context.router.replace(const SignInRoute());
      },
      onError: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("パスワードの変更に失敗しました"),
          ),
        );
      },
    );
  }

  void _showConfirmationDialog(BuildContext context, WidgetRef ref,
      UserViewModel userViewModel, String email) {
    // FIXME: ダイアログの見直し
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("パスワードを変更してよろしいですか?"),
        content: const Text("パスワード変更のメールを送信します。"),
        actionsAlignment: MainAxisAlignment.spaceAround,
        backgroundColor: BrandColor.white,
        actions: [
          TextButton(
            onPressed: () {
              _handlePasswordChange(context, ref, userViewModel, email);
            },
            child:
                const Text("OK", style: TextStyle(color: BrandColor.baseRed)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("キャンセル",
                style: TextStyle(color: BrandColor.baseRed)),
          ),
        ],
      ),
    );
  }
}
