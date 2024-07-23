import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:aizuchi_app/presentation/view/components/app_appbar.dart';
import 'package:aizuchi_app/presentation/view/components/app_button.dart';
import 'package:aizuchi_app/presentation/view/components/app_dialog.dart';
import 'package:aizuchi_app/presentation/view/components/app_loading.dart';
import 'package:aizuchi_app/presentation/view/components/app_textform.dart';
import 'package:aizuchi_app/presentation/view/pages/settings/components/list_item.dart';
import 'package:aizuchi_app/presentation/view_model/users_view_model.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class MailConfrimPage extends HookConsumerWidget {
  const MailConfrimPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userViewModel = ref.read(userViewModelProvider);
    final emailController = useTextEditingController();
    final formKey = useMemoized(GlobalKey<FormState>.new);
    return Scaffold(
      appBar: const AppAppBar(
        title: "メールアドレス変更",
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 48),
                FutureBuilder(
                    future: userViewModel.readEmail(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return ListItem(
                          title: "メールアドレス",
                          value: snapshot.data.toString(),
                          onTap: () {
                            null;
                          },
                        );
                      } else {
                        return const AppLoading();
                      }
                    }),
                const SizedBox(height: 56),
                AppTextForm.email(
                  emailController,
                  hintText: "新しいメールアドレスを入力",
                ),
                AppButton.medium(
                  text: "メールアドレスを変更",
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      userViewModel.updateEmail(
                        email: emailController.text,
                        onSuccess: () => AppDialog.showCompletedDialog(
                          context: context,
                          title: "メールアドレス変更完了",
                          content: "メールアドレスを変更しました。",
                          onPressed: () => context.router.replace(
                            const MessageRoute(),
                          ),
                        ),
                        onError: () => AppDialog.showErrorDialog(
                            context: context, title: "メールアドレス変更失敗"),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
