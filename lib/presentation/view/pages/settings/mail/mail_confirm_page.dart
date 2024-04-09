import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:aizuchi_app/presentation/view/components/app_button.dart';
import 'package:aizuchi_app/presentation/view/components/app_textform.dart';
import 'package:aizuchi_app/presentation/view/components/error_dialog.dart';
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
      appBar: AppBar(
        title: const Text(
          "加入プラン",
          style: TextStyle(color: BrandColor.black),
        ),
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
                        return const CircularProgressIndicator();
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
                        onSuccess: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("メールアドレス変更完了"),
                                content: const Text("メールアドレスを変更しました。"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      context.router
                                          .replace(const MessageRoute());
                                    },
                                    child: const Text(
                                      "OK",
                                      style:
                                          TextStyle(color: BrandColor.baseRed),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        onError: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const ErrorDialog(
                                title: "メールアドレス変更失敗",
                              );
                            },
                          );
                        },
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
