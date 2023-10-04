import 'package:aizuchi_app/infrastructure/firebase/auth_imp.dart';
import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:aizuchi_app/presentation/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/colors.dart';

import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class HumburgerMenu extends StatelessWidget {
  const HumburgerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    // 1回目に通知を飛ばす時間の作成
    tz.TZDateTime _nextInstanceOf8AM() {
      final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
      tz.TZDateTime scheduledDate =
          tz.TZDateTime(tz.local, now.year, now.month, now.day, 8);
      if (scheduledDate.isBefore(now)) {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
      }
      return scheduledDate;
    }

    Future<void> _scheduleDaily8AMNotification() async {
      final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();

      await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'OB-1',
        '本日の顔を撮影をしましょう',
        _nextInstanceOf8AM(),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'ob-1-face-daily',
            'ob-1-face-daily',
            channelDescription: 'Face photo notification',
          ),
          iOS: DarwinNotificationDetails(
            badgeNumber: 1,
          ),
        ),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
        androidAllowWhileIdle: true,
      );
    }

    final pop = Container(
      child: Column(children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: BrandColor.baseRed,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "はじめの７日間無料",
                style: TextStyle(
                    color: BrandColor.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w800),
              ),
              ElevatedButton(
                child: const Text(
                  'Premium　>',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
                style: ElevatedButton.styleFrom(
                  fixedSize: Size.fromWidth(200),
                  foregroundColor: BrandColor.baseRed,
                  backgroundColor: BrandColor.white,
                  shape: const StadiumBorder(),
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
        Text(
          "プレミアムプランでは、無制限でのチャット、広告の非表示など\n豊富な機能をおつかいいただけます。",
          style: TextStyle(
            fontSize: 8,
          ),
        )
      ]),
    );

    final spaceBox = SizedBox(
      height: 24,
    );

    final settingMenuBoxItem = Container(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8.0),
      child: Row(
        children: [
          Icon(Icons.mail_outline),
          Text("メールアドレス"),
          Text("aizuchi@com"),
          Container(
            height: 40,
            alignment: Alignment.center,
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.arrow_forward_ios,
              ),
            ),
          ),
        ],
      ),
    );

    final settingMenuBox = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            "アカウント",
          ),
        ),
        Container(
            padding: EdgeInsets.symmetric(
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: BrandColor.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  settingMenuBoxItem,
                  Divider(
                    color: Colors.grey,
                    height: 1,
                    thickness: 1,
                    indent: 8,
                    endIndent: 8,
                  ),
                  settingMenuBoxItem,
                ],
              ),
            ))
      ],
    );

    final button = Column(
      children: [
        Button(
          onPressed: () async {
            final service = AuthService();
            await service.signOut().catchError(
              (e) {
                debugPrint('サインアウトできませんでした $e');
              },
            );
            context.go(PagePath.start);
          },
          text: 'サインアウト',
        ),
        Button(
          onPressed: () async {},
          text: '通知',
        ),
      ],
    );

    final drawer = Drawer(
      child: Container(
        color: BrandColor.base,
        padding: EdgeInsets.fromLTRB(16, 80, 16, 24),
        child: Column(
          children: [
            pop,
            spaceBox,
            settingMenuBox,
            spaceBox,
            settingMenuBox,
            button,
          ],
        ),
      ),
    );

    return drawer;
  }
}
