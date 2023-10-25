import 'dart:io';

import 'package:aizuchi_app/application/state/googleauth_state.dart';
import 'package:aizuchi_app/presentation/animation/page_animation.dart';
import 'package:aizuchi_app/presentation/pages/calender_page.dart';
import 'package:aizuchi_app/presentation/pages/chat_page.dart';
import 'package:aizuchi_app/presentation/pages/loading_page.dart';
import 'package:aizuchi_app/presentation/pages/log_page.dart';
import 'package:aizuchi_app/presentation/pages/select_chat_page.dart';
import 'package:aizuchi_app/presentation/pages/start/signin_page.dart';
import 'package:aizuchi_app/presentation/pages/start/signup_page.dart';
import 'package:aizuchi_app/presentation/pages/start/signup_info.dart';
import 'package:aizuchi_app/presentation/pages/start_page.dart';
import 'package:aizuchi_app/presentation/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

part 'router.g.dart';

class PagePath {
  static const loading = '/loading';
  static const start = '/start';
  static const chat = '/chat';
  static const selectChat = '/selectChat';
  static const log = '/log';
  static const calender = '/calender';
  static const signUp = '/signUp';
  static const signIn = '/signIn';
  static const signUpInfo = '/signUpInfo';
}

//
@riverpod
GoRouter router(RouterRef ref) {
  // パスと画面の組み合わせ
  final routes = [
    GoRoute(
      path: PagePath.loading,
      pageBuilder: (_, __) => buildPageWithAnimation(
        const LoadingPage(),
      ),
    ),
    GoRoute(
      path: PagePath.start,
      pageBuilder: (_, __) => buildPageWithAnimation(
        const StartPage(),
      ),
    ),
    GoRoute(
      path: PagePath.chat,
      pageBuilder: (_, __) => buildPageWithAnimation(
        const ChatPage(),
      ),
    ),
    GoRoute(
      path: PagePath.selectChat,
      pageBuilder: (_, __) => buildPageWithAnimation(
        const SelectChatPage(),
      ),
    ),
    GoRoute(
      path: PagePath.log,
      pageBuilder: (_, __) => buildPageWithAnimation(
        const LogPage(),
      ),
    ),
    GoRoute(
      path: PagePath.calender,
      pageBuilder: (_, __) => buildPageWithAnimation(
        const CalenderPage(),
      ),
    ),
    GoRoute(
      path: PagePath.signUp,
      pageBuilder: (_, __) => buildPageWithAnimation(
        const SignUpPage(),
      ),
    ),
    GoRoute(
      path: PagePath.signIn,
      pageBuilder: (_, __) => buildPageWithAnimation(
        const SignInPage(),
      ),
    ),
    GoRoute(
      path: PagePath.signUpInfo,
      pageBuilder: (_, __) => buildPageWithAnimation(
        const SignUpInfoPage(),
      ),
    ),
  ];

  // リダイレクト - 強制的に画面を変更する
  String? redirect(BuildContext context, GoRouterState state) {
    // 表示しようとしている画面
    final page = state.uri.toString();
    // サインインしているかどうか
    final signedIn = ref.read(signedInProvider);

    print("ページ$page サインイン$signedIn");

    if (signedIn && page == PagePath.start) {
      return PagePath.chat;
    } else {
      return null;
    }
  }

  final listenable = ValueNotifier<Object?>(null);
  ref.listen<Object?>(signedInProvider, (_, newState) {
    print("リフレッシュナブル発火");
    listenable.value = newState;
  });
  ref.onDispose(listenable.dispose);

  return GoRouter(
    initialLocation: PagePath.start,
    routes: routes,
    redirect: redirect,
    refreshListenable: listenable,
  );
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    void _requestIOSPermission() {
      flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: false,
            badge: true,
            sound: false,
          );
    }

    void _initializePlatformSpecifics() {
      var initializationSettingsAndroid =
          AndroidInitializationSettings('app_icon');

      var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: false,
        onDidReceiveLocalNotification: (id, title, body, payload) async {
          // your call back to the UI
        },
      );

      var initializationSettings = InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS);

      flutterLocalNotificationsPlugin.initialize(initializationSettings,
          onDidReceiveNotificationResponse: (NotificationResponse res) {
        debugPrint('payload:${res.payload}');
      });
    }

    Future<void> _showNotification() async {
      var androidChannelSpecifics = AndroidNotificationDetails(
        'CHANNEL_ID',
        'CHANNEL_NAME',
        channelDescription: "CHANNEL_DESCRIPTION",
        importance: Importance.max,
        priority: Priority.high,
        playSound: false,
        timeoutAfter: 5000,
        styleInformation: DefaultStyleInformation(true, true),
      );

      var iosChannelSpecifics = DarwinNotificationDetails();

      var platformChannelSpecifics = NotificationDetails(
          android: androidChannelSpecifics, iOS: iosChannelSpecifics);

      await flutterLocalNotificationsPlugin.show(
        0, // Notification ID
        'Test Title', // Notification Title
        'Test Body', // Notification Body, set as null to remove the body
        platformChannelSpecifics,
        payload: 'New Payload', // Notification Payload
      );
    }

    // ここから追加
    Future<void> _scheduleNotification() async {
      // 5秒後
      var scheduleNotificationDateTime =
          DateTime.now().add(Duration(seconds: 5));

      var androidChannelSpecifics = AndroidNotificationDetails(
        'CHANNEL_ID 1',
        'CHANNEL_NAME 1',
        channelDescription: "CHANNEL_DESCRIPTION 1",
        icon: 'app_icon',
        //sound: RawResourceAndroidNotificationSound('my_sound'),
        largeIcon: DrawableResourceAndroidBitmap('app_icon'),
        enableLights: true,
        color: const Color.fromARGB(255, 255, 0, 0),
        ledColor: const Color.fromARGB(255, 255, 0, 0),
        ledOnMs: 1000,
        ledOffMs: 500,
        importance: Importance.max,
        priority: Priority.high,
        playSound: false,
        timeoutAfter: 5000,
        styleInformation: DefaultStyleInformation(true, true),
      );

      var iosChannelSpecifics = DarwinNotificationDetails(
          //sound: 'my_sound.aiff',
          );

      var platformChannelSpecifics = NotificationDetails(
        android: androidChannelSpecifics,
        iOS: iosChannelSpecifics,
      );

      await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'Test Title',
        'Test Body',
        tz.TZDateTime.from(scheduleNotificationDateTime, tz.local), // 5秒後に表示
        platformChannelSpecifics,
        payload: 'Test Payload',
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    }

    useEffect(() {
      if (Platform.isIOS) {
        _requestIOSPermission();
        _initializePlatformSpecifics();
        _scheduleNotification();
      }
    }, []);

    return MaterialApp.router(
      theme: brandThemeData,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
