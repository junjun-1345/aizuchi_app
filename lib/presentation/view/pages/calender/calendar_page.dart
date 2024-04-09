import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:aizuchi_app/presentation/state/message_state.dart';
import 'package:aizuchi_app/presentation/state/user_providers.dart';
import 'package:aizuchi_app/presentation/view/components/drawer_content.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class CalenderPage extends ConsumerWidget {
  const CalenderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = context.router;
    Future<void> signOut() async {
      await FirebaseAuth.instance.signOut();
      router.replace(const SignInRoute());
      // final authenticated = FirebaseAuth.instance.currentUser != null;
      // print(authenticated);
    }

    return Scaffold(
      drawer: const HamburgerMenu(),
      drawerScrimColor: BrandColor.base,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: BrandColor.textBlack),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('CalenderPage'),
            ElevatedButton(
              onPressed: () {
                ref.read(userIsConversationProvider.notifier).state = true;
              },
              child: const Text('isConversationProvider True'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(userIsConversationProvider.notifier).state = false;
              },
              child: const Text('isConversationProvider False'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(userDailyKeyProvider.notifier).state = "";
              },
              child: const Text('daiky Key Reset'),
            ),
            ElevatedButton(
              onPressed: () {
                // print(ref.watch(datetimeKeyProvider).toString());

                ref.read(userIsConversationProvider.notifier).state = false;
                // ref.read(diaryKeyProvider.notifier).state = "";
                ref.read(messagesNotifierProvider.notifier).deleteAll();
              },
              child: const Text('reset'),
            ),
            ElevatedButton(
              onPressed: () {
                signOut();
              },
              child: const Text('LOGOUT'),
            ),
            const Text('daily'),
          ],
        ),
      ),
    );
  }
}
