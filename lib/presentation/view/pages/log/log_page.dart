import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:aizuchi_app/presentation/state/daily_state.dart';
import 'package:aizuchi_app/presentation/state/user_state.dart';
import 'package:aizuchi_app/presentation/view/pages/log/components/log_carousel.dart';
import 'package:aizuchi_app/presentation/view/pages/log/components/log_summary_tile.dart';
import 'package:aizuchi_app/presentation/view_model/log_view_model.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
