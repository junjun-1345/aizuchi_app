import 'package:aizuchi_app/domain/entity/enums/emotion.dart';
import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:aizuchi_app/presentation/state/daily_state.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class LogPage extends ConsumerWidget {
  const LogPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> signOut() async {
      await FirebaseAuth.instance.signOut();
      context.router.replace(const SignInRoute());
      // final authenticated = FirebaseAuth.instance.currentUser != null;
      // print(authenticated);
    }

    return Center(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            const Text('MessagePage'),
            Expanded(
              child: ref.watch(dailyNotifierProvider).when(
                    data: (dailies) => ListView.builder(
                      // reverse: true,
                      itemCount: dailies.length,
                      itemBuilder: (context, index) {
                        final daily = dailies[index];
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(daily.createdAt.toString()),
                                const SizedBox(width: 8),
                                Text(
                                  daily.emotion.emotionValue ?? '',
                                  style: const TextStyle(fontSize: 24),
                                ),
                              ],
                            ),
                            Text(daily.summary),
                          ],
                        );
                      },
                    ),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (error, _) =>
                        Center(child: Text('エラーが発生しました: $error')),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
