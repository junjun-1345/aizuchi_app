import 'package:aizuchi_app/domain/domain_module.dart';
import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:aizuchi_app/firebase_options_dev.dart' as dev;
import 'package:aizuchi_app/firebase_options_stg.dart' as stg;
import 'package:aizuchi_app/firebase_options_prod.dart' as prod;

import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

const flavor = String.fromEnvironment('flavor');
const googleReversedClientId = String.fromEnvironment('googleReversedClientId');

///
/// settings
///

void main() async {
  await initializeDateFormatting();
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation("Asia/Tokyo"));

  final FirebaseOptions firebaseOptions;
  switch (flavor) {
    case "dev":
      firebaseOptions = dev.DefaultFirebaseOptions.currentPlatform;
    case "stg":
      firebaseOptions = stg.DefaultFirebaseOptions.currentPlatform;
    case "prd":
      firebaseOptions = prod.DefaultFirebaseOptions.currentPlatform;
    default:
      firebaseOptions = dev.DefaultFirebaseOptions.currentPlatform;
  }

  await Firebase.initializeApp(options: firebaseOptions);

  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  String appName = packageInfo.appName;
  String packageName = packageInfo.packageName;
  String version = packageInfo.version;
  String buildNumber = packageInfo.buildNumber;

  if (kDebugMode) {
    print('appName: $appName');
    print('packageName: $packageName');
    print('version: $version');
    print('buildNumber: $buildNumber');
  }

  const app = MyApp();
  const scope = ProviderScope(child: app);
  runApp(scope);
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(appRouterProvider);
    //FIXME: 呼び出す階層を変更
    ref.read(subscriptionUsecaseProvider).configureSDK();

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
