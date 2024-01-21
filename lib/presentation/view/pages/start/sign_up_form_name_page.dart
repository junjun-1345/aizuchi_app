import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:aizuchi_app/presentation/view/widget/sign_up_form_widget.dart';
import 'package:aizuchi_app/presentation/view_model/user_view_model.dart';
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
    final nameNotifier = ref.watch(userNameProvider.notifier);

    final formKey = useMemoized(GlobalKey<FormState>.new);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const SignUpFormWidget(
                        content: 'ニックネーム',
                        index: 1,
                      ),
                      SizedBox(
                        height: 80,
                        child: TextFormField(
                          controller: nameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'ニックネームを入力してください';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 16),
                            hintText: "ニックネームを入力",
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
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(
                        width: 40,
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
    );
  }
}
