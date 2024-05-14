import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:aizuchi_app/presentation/view/components/app_button.dart';
import 'package:aizuchi_app/presentation/view/components/drawer_content.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class MeasurementPage extends HookConsumerWidget {
  const MeasurementPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      drawer: const HamburgerMenu(),
      drawerScrimColor: BrandColor.base,
      appBar: AppBar(
        title: const Text(
          "こころの計測",
          style: TextStyle(fontSize: 20, color: BrandColor.textBlack),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: BrandColor.textBlack),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              _menuContent(
                title: "憂うつレベル(PHQ-9)",
                description: "９個の質問で、「憂うつレベル」を測定します。",
                imgUrl: "mofumofu_icon_1.png",
                onPreviousResults: null,
                onStart: null,
                context: context,
              ),
              const SizedBox(
                height: 16,
              ),
              _menuContent(
                title: "ストレスチェック",
                description: "30個の質問で「ストレスレベル」を測定します。",
                imgUrl: "mofumofu_icon_2.png",
                onPreviousResults: null,
                onStart: null,
                context: context,
              ),
              const SizedBox(
                height: 16,
              ),
              _menuContent(
                title: "睡眠レベル(アテネ不眠尺度)",
                description: "8個の質問で「睡眠レベル」を測定します。",
                imgUrl: "mofumofu_icon_3.png",
                onPreviousResults: null,
                onStart: null,
                context: context,
              ),
              const SizedBox(
                height: 16,
              ),
              const Text("アップデートにて順次公開予定です。")
            ],
          ),
        ),
      ),
    );
  }

  Widget _menuContent({
    required String title,
    required String description,
    required String imgUrl,
    required void Function()? onPreviousResults,
    required void Function()? onStart,
    required BuildContext context,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: BrandColor.white,
        borderRadius: BorderRadius.circular(8),
      ),
      height: 140,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.psychology_alt_outlined,
                color: BrandColor.baseRed,
                size: 36,
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
          Text(description),
          Row(
            children: [
              AppButton.small(
                width: MediaQuery.of(context).size.width * 0.31,
                height: MediaQuery.of(context).size.width * 0.08,
                onPressed: onPreviousResults,
                text: '前回の結果',
                textStyle: const TextStyle(
                    fontWeight: FontWeight.w800, color: BrandColor.white),
              ),
              const SizedBox(
                width: 8,
              ),
              AppButton.small(
                width: MediaQuery.of(context).size.width * 0.31,
                height: MediaQuery.of(context).size.width * 0.08,
                onPressed: onStart,
                text: 'はじめる',
                textStyle: const TextStyle(
                    fontWeight: FontWeight.w800, color: BrandColor.white),
              ),
              const Spacer(),
              Image.asset(
                'assets/images/$imgUrl',
                height: MediaQuery.of(context).size.height * 0.08,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
