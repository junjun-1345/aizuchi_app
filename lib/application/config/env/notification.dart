import 'dart:io';
import 'dart:ui';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/subjects.dart';
import 'package:http/http.dart' as http;
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/material.dart';

// class NotificationService {
//   NotificationService();

//   final _localNotifications = FlutterLocalNotificationsPlugin();
//   final BehaviorSubject<String> behaviorSubject = BehaviorSubject();

//   // 0-1、ここで定義した処理を main.dart から呼び出せる
//   Future<void> initializePlatformNotifications() async {
//     // アセットの名前がアプリのアイコンとして表示
//     // android/app/src/main/res/drawable をフォルダーに追加する必要あり
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('justwater');

//     final IOSInitializationSettings initializationSettingsIOS =
//         IOSInitializationSettings(
//             requestSoundPermission: true,
//             requestBadgePermission: true,
//             requestAlertPermission: true,
//             onDidReceiveLocalNotification: onDidReceiveLocalNotification);

//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsIOS,
//     );

//     await _localNotifications.initialize(initializationSettings,
//         onSelectNotification: selectNotification);

//     // タイムゾーン設定
//     tz.initializeTimeZones();
//     tz.setLocalLocation(
//       tz.getLocation('Asia/Tokyo'
//           // await FlutterNativeTimezone.getLocalTimezone(),
//           ),
//     );
//   }

//   // 0-2、
//   void onDidReceiveLocalNotification(
//       int id, String? title, String? body, String? payload) {
//     debugPrint('id ----- $id');
//   }

//   // 0-3、リスナーが受け取るデータ ストリーム イベントにペイロードを追加
//   void selectNotification(String? payload) {
//     debugPrint("selectNotification payload ----- $payload");
//     if (payload != null && payload.isNotEmpty) {
//       behaviorSubject.add(payload);
//     }
//   }

//   // 各プラットフォームの通知のプッシュの見た目設定
// 　// ここに次をコピペ

// 　// 処理１(Drink Now)
//   // ここに処理１を書く

//   // 処理２
// 　// ここに処理２を書く
// }