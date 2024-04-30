import 'package:aizuchi_app/presentation/state/user_providers.dart';
import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:aizuchi_app/presentation/view/components/app_textform.dart';
import 'package:aizuchi_app/presentation/view/pages/start/components/sign_up_form_widget.dart';
import 'package:aizuchi_app/presentation/view_model/users_view_model.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class SignUpFormNamePage extends HookConsumerWidget {
  const SignUpFormNamePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController();
    final nameNotifier = ref.read(userNameProvider.notifier);
    final UserViewModel userViewModel = ref.read(userViewModelProvider);

    final formKey = useMemoized(GlobalKey<FormState>.new);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Form(
              key: formKey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SignUpFormWidget(
                      content: 'ニックネーム',
                      index: 1,
                    ),
                    AppTextForm.medium(
                      nameController,
                      hintText: "ニックネームを入力",
                      validatorhintText: "ニックネームを入力してください",
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () {
                            userViewModel.signOut();
                            context.router.maybePop(
                              const SignUpRoute(),
                            );
                          },
                          icon: const Icon(Icons.arrow_back),
                        ),
                        IconButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              context.router.push(
                                const SignUpFormSexRoute(),
                              );
                              nameNotifier.state = nameController.text;
                            }
                          },
                          icon: const Icon(Icons.arrow_forward),
                        ),
                      ],
                    ),
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
