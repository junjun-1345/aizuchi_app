import 'dart:developer';

import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:aizuchi_app/rearchitecture/domain/user_data/entity.dart';
import 'package:aizuchi_app/rearchitecture/feature/profile/components/profile_tile.dart';
import 'package:aizuchi_app/rearchitecture/feature/profile/view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfilePage extends HookConsumerWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profilePageViewModelProvider);
    return state.when(
      data: (data) {
        final UserData userInfo = data.userInfo;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: BrandColor.baseLight,
            title: Text(userInfo.id),
            titleTextStyle:
                const TextStyle(fontSize: 16, color: BrandColor.black),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              children: [
                const SizedBox(height: 24),
                ReProfileTile(
                  title: 'お名前',
                  value: userInfo.name ?? '',
                ),
                // ReProfileTile(
                //   title: 'メールアドレス',
                //   value: userInfo.email ?? '',
                // ),
                ReProfileTile(
                  title: '誕生日',
                  value: userInfo.birthday.toString(),
                ),
                ReProfileTile(
                  title: '職業',
                  value: userInfo.profession ?? '',
                ),
                ReProfileTile(
                  title: 'キャラクター',
                  value: userInfo.charactor ?? '',
                ),
                ReProfileTile(
                  title: 'DailyKey',
                  value: userInfo.dailyKey ?? '',
                ),
                ReProfileTile(
                  title: '登録日',
                  value: userInfo.createdAt.toString(),
                ),
                ReProfileTile(
                  title: 'ActiveDay',
                  value: userInfo.activeDay.toString(),
                ),
                ReProfileTile(
                  title: '合計メッセージ数',
                  value: userInfo.totalMessage.toString(),
                ),
              ],
            ),
          ),
        );
      },
      error: (error, stackTrace) => ElevatedButton(
        child: Text(error.toString()),
        onPressed: () {
          log(error.toString());
          log(stackTrace.toString());
        },
      ),
      loading: () => const Center(
        child: Text('loading...'),
      ),
    );
  }
}
