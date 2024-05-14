import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:aizuchi_app/infrastructure/data_model.dart';
import 'package:aizuchi_app/infrastructure/enums/auth_provider.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class AuthenticationCooperationPage extends HookConsumerWidget {
  const AuthenticationCooperationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authRepository = ref.read(authRepositoryProvider);
    final getCurrentUserProviders = authRepository.getCurrentUserProvider();
    return Scaffold(
      appBar: AppBar(
        title: const Text("認証連携", style: TextStyle(color: BrandColor.black)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: BrandColor.textBlack),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: FutureBuilder(
            future: getCurrentUserProviders,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return const Text("エラーが発生しました");
              }
              return Column(
                children: [
                  const SizedBox(height: 48),
                  Container(
                    decoration: BoxDecoration(
                      color: BrandColor.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    height: 48,
                    padding: const EdgeInsets.symmetric(
                        vertical: 0, horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "認証プラットフォーム",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Icon(snapshot.data!.first.icon,
                            color: BrandColor.textBlack),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
