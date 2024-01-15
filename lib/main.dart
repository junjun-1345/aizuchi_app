import 'package:aizuchi_app/domain/entity/model/color.dart';
import 'package:aizuchi_app/firebase_options.dart';
import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

///
/// settings
///

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation("Asia/Tokyo"));

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  const app = MyApp();
  const scope = ProviderScope(child: app);
  runApp(scope);
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(appRouterProvider);

    return MaterialApp.router(
      routerConfig: appRouter.config(
          // 再評価するリスナーを設定
          // reevaluateListenable: authProvider,
          ),
      title: 'Flutter Demo',
      color: BrandColor.base,
      theme: ThemeData(
        scaffoldBackgroundColor: BrandColor.base,
        primarySwatch: Colors.blue,
        fontFamily: 'ZenMaruGothic',
      ),
    );
  }
}
