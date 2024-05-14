import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class CharacterSelectPage extends HookConsumerWidget {
  const CharacterSelectPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text("キャラクター選択", style: TextStyle(color: BrandColor.black)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: BrandColor.textBlack),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 48),
              Container(
                decoration: BoxDecoration(
                  color: BrandColor.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                height: 48,
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "アップデートで順次追加",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}