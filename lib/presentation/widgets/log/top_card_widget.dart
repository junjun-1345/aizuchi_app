import 'package:aizuchi_app/application/state/firestore.dart';
import 'package:aizuchi_app/domain/features/datetime.dart';
import 'package:aizuchi_app/presentation/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TopCardWidget extends ConsumerWidget {
  const TopCardWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerState = ref.watch(userProvider);
    final messagesState = ref.watch(messageCountIntProvider);
    final dailyState = ref.watch(dailyCountIntProvider);

    final registerDay = switch (registerState) {
      // 通信が終わったら テキスト
      AsyncData(:final value) => Text(
          CustomDateTime()
              .nowDateDateTime()
              .difference(DateTime.parse(value["registerDay"]))
              .inDays
              .toString(),
          style: TextStyle(fontSize: 24.0, color: BrandColor.white),
        ),
      // 通信中は グルグル
      AsyncValue() => const CircularProgressIndicator(),
    };

    final messages = switch (messagesState) {
      // 通信が終わったら テキスト
      AsyncData(:final value) => Text(
          value.toString(),
          style: TextStyle(fontSize: 24.0, color: BrandColor.white),
        ),
      // 通信中は グルグル
      AsyncValue() => const CircularProgressIndicator(),
    };

    final activeDay = switch (dailyState) {
      // 通信が終わったら テキスト
      AsyncData(:final value) => Text(
          value.toString(),
          style: TextStyle(fontSize: 24.0, color: BrandColor.white),
        ),
      // 通信中は グルグル
      AsyncValue() => const CircularProgressIndicator(),
    };

    // カードの中身
    Widget container(IconData icon, String title, Widget widget, String unit) {
      return Column(
        children: [
          Icon(
            icon,
            size: 36.0,
            color: BrandColor.white,
          ),
          Text(
            title,
            style: TextStyle(color: BrandColor.white),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              widget,
              Text(
                unit,
                style: TextStyle(color: BrandColor.white),
              )
            ],
          )
        ],
      );
    }

    //////////////////////
    // レイアウトの構成
    //////////////////////
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
      child: Card(
        color: BrandColor.baseRed, // Card自体の色
        elevation: 0, // 影の離れ具合
        shadowColor: Colors.black, // 影の色
        shape: RoundedRectangleBorder(
          // 枠線を変更できる
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              container(
                Icons.check_circle_outline_sharp,
                "登録から",
                registerDay,
                "日目",
              ),
              container(
                Icons.chat_rounded,
                "会話数",
                messages,
                "回",
              ),
              container(
                Icons.forum_outlined,
                "会話した日",
                activeDay,
                "回",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
