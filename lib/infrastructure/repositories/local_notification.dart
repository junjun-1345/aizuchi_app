import 'dart:async';
import 'dart:io';

import 'package:aizuchi_app/domain/repositories/local_notification_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// アプリが通知イベントを受信したときに反応できるようにするためのストリームコントローラー
final StreamController<ReceivedNotification> didReceiveLocalNotificationStream =
    StreamController<ReceivedNotification>.broadcast();
final StreamController<String?> selectNotificationStream =
    StreamController<String?>.broadcast();

class ReceivedNotification {
  final int id;
  final String? title;
  final String? body;
  final String? payload;

  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });
}

// 定数で通知アクションのIDを定義
const String urlLaunchActionId = 'id_1';
const String navigationActionId = 'id_3';
const String darwinNotificationCategoryText = 'textCategory';
const String darwinNotificationCategoryPlain = 'plainCategory';

// バックグラウンドで通知のアクションがタップされたときに呼び出される関数
@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  if (kDebugMode) {
    print(
        'Notification(${notificationResponse.id}) action tapped: ${notificationResponse.actionId} with payload: ${notificationResponse.payload}');
    if (notificationResponse.input?.isNotEmpty ?? false) {
      print(
          'Notification action tapped with input: ${notificationResponse.input}');
    }
  }
}

// ローカル通知に関する操作を行うリポジトリの実装
class LocalNotificationRepositoryImpl implements LocalNotificationRepository {
  @override
  Future<void> test() {
    throw UnimplementedError();
  }

  @override
  Future<void> initializeNotifications() async {
    await requestPermission();
    await _initializeNotifications();
  }

  @override
  Future<void> scheduleDailyNotificationAt(int hour, int minute) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'もうふちゃん',
        '今日も一日おつかれさま🐑🫧今日はどんな1日だった〜？',
        _scheduleNextInstance(hour, minute),
        const NotificationDetails(
          android: AndroidNotificationDetails('daily notification channel id',
              'daily notification channel name',
              channelDescription: 'daily notification description'),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  @override
  Future<void> cancelAllNotifications() async {
    print("cancelAllNotifications");
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  @override
  Future<void> requestPermission() async {
    print("通知許可をリクエストします");
    if (Platform.isIOS || Platform.isMacOS) {
      await _requestPermissionsIOSMac();
    } else if (Platform.isAndroid) {
      await _requestPermissionsAndroid();
    }
  }

  @override
  Future<bool> checkNotificationPermission() async {
    final bool? isGranted = await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    return isGranted ?? false;
  }

  Future<void> _requestPermissionsIOSMac() async {
    var iosMacNotificationsPlugin =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>();
    await iosMacNotificationsPlugin?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> _requestPermissionsAndroid() async {
    var androidNotificationsPlugin =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    await androidNotificationsPlugin?.requestNotificationsPermission();
  }

  Future<void> _initializeNotifications() async {
    final initializationSettings = InitializationSettings(
      android: const AndroidInitializationSettings('app_icon'),
      iOS: _createDarwinInitializationSettings(),
      macOS: _createDarwinInitializationSettings(),
      linux: LinuxInitializationSettings(
        defaultActionName: 'Open notification',
        defaultIcon: AssetsLinuxIcon('icons/app_icon.png'),
      ),
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _handleNotificationResponse,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
  }

  // Darwinプラットフォーム（iOSおよびMacOS）用の初期化設定を作成
  DarwinInitializationSettings _createDarwinInitializationSettings() {
    return DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {
          didReceiveLocalNotificationStream.add(ReceivedNotification(
              id: id, title: title, body: body, payload: payload));
        },
        notificationCategories: [
          DarwinNotificationCategory(
            darwinNotificationCategoryText,
            actions: [
              DarwinNotificationAction.text('text_1', 'Action 1',
                  buttonTitle: 'Send', placeholder: 'Placeholder'),
            ],
          ),
          DarwinNotificationCategory(
            darwinNotificationCategoryPlain,
            actions: [
              DarwinNotificationAction.plain('id_1', 'Action 1'),
              DarwinNotificationAction.plain('id_2', 'Action 2 (destructive)',
                  options: {DarwinNotificationActionOption.destructive}),
              DarwinNotificationAction.plain(
                  navigationActionId, 'Action 3 (foreground)',
                  options: {DarwinNotificationActionOption.foreground}),
              DarwinNotificationAction.plain('id_4', 'Action 4 (auth required)',
                  options: {
                    DarwinNotificationActionOption.authenticationRequired
                  }),
            ],
            options: {DarwinNotificationCategoryOption.hiddenPreviewShowTitle},
          )
        ]);
  }

  // 通知のレスポンスをハンドルする
  void _handleNotificationResponse(NotificationResponse response) {
    if (response.notificationResponseType ==
        NotificationResponseType.selectedNotification) {
      selectNotificationStream.add(response.payload);
    } else if (response.notificationResponseType ==
            NotificationResponseType.selectedNotificationAction &&
        response.actionId == navigationActionId) {
      selectNotificationStream.add(response.payload);
    }
  }

  tz.TZDateTime _scheduleNextInstance(int hour, int minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }
}
