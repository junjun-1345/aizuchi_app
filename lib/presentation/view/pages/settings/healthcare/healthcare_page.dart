import 'package:aizuchi_app/presentation/view/components/app_appbar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class HealthcarePage extends HookConsumerWidget {
  const HealthcarePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      appBar: AppAppBar(
        title: "ヘルスケア連携",
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 48),
              Text("アップデートで順次追加"),
            ],
          ),
        ),
      ),
    );
  }
}
