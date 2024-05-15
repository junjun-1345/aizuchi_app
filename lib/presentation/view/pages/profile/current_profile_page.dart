import 'package:aizuchi_app/domain/entity/enums/sex.dart';
import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:aizuchi_app/presentation/state/user_state.dart';
import 'package:aizuchi_app/presentation/view/components/app_appbar.dart';
import 'package:aizuchi_app/presentation/view/pages/profile/components/profile_tile.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

@RoutePage()
class CurrentProfilePage extends HookConsumerWidget {
  const CurrentProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(usersNotifierProvider);

    return Scaffold(
      appBar: const AppAppBar(
        title: 'プロフィール',
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: userState.when(
            data: (data) {
              return Column(
                children: [
                  const SizedBox(
                    height: 48,
                  ),
                  ProfileTile(
                    title: 'ニックネーム',
                    currentData: data.name,
                  ),
                  ProfileTile(
                    title: '性別',
                    currentData: data.sex.sexValue ?? '',
                  ),
                  ProfileTile(
                    title: '生年月日',
                    currentData: DateFormat('yyyy/MM/dd').format(data.birthday),
                  ),
                  ProfileTile(
                    title: '職業',
                    currentData: data.profession,
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
                        onPressed: () {
                          context.router.push(const EditProfileRoute());
                        },
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
