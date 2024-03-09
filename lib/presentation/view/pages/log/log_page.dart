import 'package:aizuchi_app/domain/entity/enums/emotion.dart';
import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:aizuchi_app/presentation/state/daily_state.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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

    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('ログ'),
        LogSummaryTile(),
        SizedBox(
          height: 24,
        ),
        LogCarousel(),
        SizedBox(
          height: 24,
        ),
      
      ],
    );
  }
}
