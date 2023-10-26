import 'package:aizuchi_app/application/config/local_notification.dart';
import 'package:aizuchi_app/infrastructure/firebase/auth_imp.dart';
import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:aizuchi_app/presentation/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../theme/colors.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class HumburgerMenu extends StatelessWidget {
  const HumburgerMenu({super.key});

  ///
  /// HACK
  ///

  @override
  Widget build(BuildContext context) {
    final spaceBox = SizedBox(
      height: 24,
    );

    Widget settingMenuBoxItem(String content, IconData icon) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8.0),
        child: Row(
          children: [
            Icon(icon),
            Text(content),
            Container(
              height: 40,
              alignment: Alignment.center,
              child: IconButton(
                onPressed: () {
                  context.go(PagePath.notification);
                },
                icon: Icon(
                  Icons.arrow_forward_ios,
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget settingMenuBox = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            "機能",
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
                  settingMenuBoxItem("通知設定", Icons.access_alarm),
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
            Container(
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
            ),
            spaceBox,
            settingMenuBox,
            spaceBox,
            settingMenuBox,
            button,
            ElevatedButton(
              onPressed: () async {
                LocalNotificationService().showNotification();
              },
              child: const Text("今すぐ通知"),
            ),
          ],
        ),
      ),
    );

    return drawer;
  }
}
