import 'package:aizuchi_app/domain/entity/enums/sex.dart';
import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:aizuchi_app/presentation/state/user_state.dart';
import 'package:aizuchi_app/presentation/view/components/app_appbar.dart';
import 'package:aizuchi_app/presentation/view/components/app_textform.dart';
import 'package:aizuchi_app/presentation/view/pages/profile/components/edit_profile_dialog.dart';
import 'package:aizuchi_app/presentation/view/pages/profile/components/edit_sex_dialog.dart';
import 'package:aizuchi_app/presentation/view/pages/profile/components/profile_tile.dart';
import 'package:aizuchi_app/presentation/view_model/users_view_model.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

@RoutePage()
class EditProfilePage extends HookConsumerWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(usersNotifierProvider);
    final userViewModel = ref.read(userViewModelProvider);

    return Scaffold(
      appBar: const AppAppBar(
        title: "プロフィール",
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: userState.when(
            data: (data) {
              final nameController = useTextEditingController(text: data.name);
              final choiceProfession = useState(data.profession);
              final choiceSex = useState(data.sex);
              final choiceBirthday = useState(data.birthday);
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 48,
                    ),
                    AppTextForm.medium(
                      nameController,
                      hintText: "ニックネーム",
                      validatorhintText: "ニックネームを入力してください",
                    ),
                    GestureDetector(
                      onTap: () => showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => EditSexDialog(
                          choiceSex: choiceSex,
                          choicedSex: choiceSex.value,
                        ),
                      ),
                      child: ProfileTile(
                        title: '性別',
                        currentData: choiceSex.value.sexValue ?? '',
                        withBorder: true,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          minTime: DateTime(1900, 1, 1),
                          maxTime: DateTime.now(), onConfirm: (date) {
                        choiceBirthday.value = date;
                      }, currentTime: data.birthday, locale: LocaleType.jp),
                      child: ProfileTile(
                        title: '生年月日',
                        currentData: DateFormat('yyyy/MM/dd')
                            .format(choiceBirthday.value),
                        withBorder: true,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => EditProffesionDialog(
                          choicedProfession: choiceProfession.value,
                          choiceProfession: choiceProfession,
                        ),
                      ),
                      child: ProfileTile(
                        title: '職業',
                        currentData: choiceProfession.value,
                        withBorder: true,
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: BrandColor.white,
                            backgroundColor: BrandColor.baseRed,
                            elevation: 0,
                          ),
                          onPressed: () async => userViewModel.updateProfile(
                                name: nameController.text.trim(),
                                sex: choiceSex.value,
                                birthday: choiceBirthday.value,
                                profession: choiceProfession.value,
                                onSuccess: () {
                                  ref.invalidate(usersNotifierProvider);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("プロフィールが変更されました"),
                                    ),
                                  );
                                  context.router.maybePop();
                                },
                                onError: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("プロフィールの変更に失敗しました"),
                                    ),
                                  );
                                },
                              ),
                          child: const Text(
                            '変更',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                    ),
                  ],
                ),
              );
            },
            loading: () {
              return const CircularProgressIndicator();
            },
            error: (Object error, StackTrace stackTrace) {
              return const Text("エラーが発生しました");
            },
          )),
    );
  }
}
