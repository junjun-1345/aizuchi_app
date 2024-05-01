import 'package:aizuchi_app/domain/entity/enums/sex.dart';
import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:aizuchi_app/presentation/state/user_state.dart';
import 'package:aizuchi_app/presentation/view/components/app_textform.dart';
import 'package:aizuchi_app/presentation/view/pages/profile/components/edit_profile_dialog.dart';
import 'package:aizuchi_app/presentation/view/pages/profile/components/profile_tile.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

@RoutePage()
class EditProfilePage extends HookConsumerWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController();
    final userState = ref.watch(usersNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('プロフィール編集'),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: userState.when(
            data: (data) {
              final choiceProfession = useState(data.profession);

              return Column(
                children: [
                  const SizedBox(
                    height: 48,
                  ),
                  AppTextForm.medium(
                    nameController,
                    hintText: "ニックネーム",
                    validatorhintText: "ニックネームを入力してください",
                  ),
                  ProfileTile(
                    title: '性別',
                    currentData: data.sex.sexValue ?? '',
                  ),
                  ProfileTile(
                    title: '生年月日',
                    currentData: DateFormat('yyyy/MM/dd').format(data.birthday),
                  ),
                  GestureDetector(
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) => EditProffesionDialog(
                        choicedProfession: choiceProfession.value,
                        choiceProfession: choiceProfession,
                      ),
                    ),
                    child: ProfileTile(
                      title: '職業',
                      currentData: choiceProfession.value,
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
                        onPressed: () {},
                        child: const Text(
                          'プロフィール設定',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  )
                ],
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
