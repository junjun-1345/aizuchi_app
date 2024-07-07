import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:aizuchi_app/rearchitecture/domain/user/entity.dart';
import 'package:aizuchi_app/rearchitecture/presentation/pages/profile/components/profile_list_item.dart';
import 'package:aizuchi_app/rearchitecture/presentation/pages/profile/view_model.dart';
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
                ProfileListItem(
                  title: 'お名前',
                  value: userInfo.name ?? '',
                ),
                ProfileListItem(
                  title: 'メールアドレス',
                  value: userInfo.email ?? '',
                ),
                ProfileListItem(
                  title: '誕生日',
                  value: userInfo.birthday.toString(),
                ),
                ProfileListItem(
                  title: '職業',
                  value: userInfo.profession ?? '',
                ),
                ProfileListItem(
                  title: 'キャラクター',
                  value: userInfo.charactor ?? '',
                ),
                ProfileListItem(
                  title: 'DailyKey',
                  value: userInfo.dailyKey ?? '',
                ),
                ProfileListItem(
                  title: '登録日',
                  value: userInfo.createdAt.toString(),
                ),
                ProfileListItem(
                  title: 'ActiveDay',
                  value: userInfo.activeDay.toString(),
                ),
                ProfileListItem(
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
          print(error.toString());
          print(stackTrace.toString());
        },
      ),
      loading: () => const Center(
        child: Text('loading...'),
      ),
    );
  }
}
