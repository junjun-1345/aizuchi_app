import 'package:aizuchi_app/infrastructure/firebase/auth_imp.dart';
import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:aizuchi_app/presentation/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../theme/colors.dart';

import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class HumburgerMenu extends StatelessWidget {
  const HumburgerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    Widget spaceBox = SizedBox(
      height: 24,
    );

    Widget settingMenuBoxItem = Container(
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

    Widget button = Column(
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
        Button(
          onPressed: () async {
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();
            await prefs.setInt('counter', 1000);
          },
          text: '登録',
        ),
        Button(
          onPressed: () async {
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();
            final int? counter = prefs.getInt('counter');
            print("読込$counter");
          },
          text: '読込',
        ),
      ],
    );

    Widget drawer = Drawer(
      child: Container(
        color: BrandColor.base,
        padding: EdgeInsets.fromLTRB(16, 80, 16, 24),
        child: Column(
          children: [
            // POP
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
            // setting
            Column(
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
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 8.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.notifications_active,
                                ),
                                Text("通知設定"),
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
                          ),
                        ],
                      ),
                    ))
              ],
            ),
            spaceBox,
            // account
            Column(
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
            ),
            button,
          ],
        ),
      ),
    );

    return drawer;
  }
}
