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
        padding: EdgeInsets.fromLTRB(16, 56, 16, 24),
        child: Column(
          children: [
            //
            // POP
            //
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
            //
            // 機能
            //
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
                    decoration: BoxDecoration(
                      color: BrandColor.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Container(
                            height: 40,
                            padding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.access_alarm),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text("通知設定"),
                                  ],
                                ),
                                IconButton(
                                  onPressed: () {
                                    context.go(PagePath.notification);
                                  },
                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                    color: BrandColor.baseRed,
                                  ),
                                  iconSize: 24,
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.black,
                            height: 4,
                            indent: 8,
                            endIndent: 8,
                          ),
                          Container(
                            height: 40,
                            padding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.lock),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text("PINロック"),
                                  ],
                                ),
                                IconButton(
                                  onPressed: () {
                                    context.go(PagePath.notification);
                                  },
                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                    color: BrandColor.baseRed,
                                  ),
                                  iconSize: 24,
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
            //
            // アカウント
            //
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
                    decoration: BoxDecoration(
                      color: BrandColor.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Container(
                            height: 40,
                            padding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.account_circle,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text("ニックネーム"),
                                  ],
                                ),
                                IconButton(
                                  onPressed: () {
                                    context.go(PagePath.notification);
                                  },
                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                    color: BrandColor.baseRed,
                                  ),
                                  iconSize: 24,
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.black,
                            height: 4,
                            indent: 8,
                            endIndent: 8,
                          ),
                          Container(
                            height: 40,
                            padding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.mail,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text("メールアドレス"),
                                  ],
                                ),
                                IconButton(
                                  onPressed: () {
                                    context.go(PagePath.notification);
                                  },
                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                    color: BrandColor.baseRed,
                                  ),
                                  iconSize: 24,
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.black,
                            height: 4,
                            indent: 8,
                            endIndent: 8,
                          ),
                          Container(
                            height: 40,
                            padding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.accessibility_new,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text("性別"),
                                  ],
                                ),
                                IconButton(
                                  onPressed: () {
                                    context.go(PagePath.notification);
                                  },
                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                    color: BrandColor.baseRed,
                                  ),
                                  iconSize: 24,
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.black,
                            height: 4,
                            indent: 8,
                            endIndent: 8,
                          ),
                          Container(
                            height: 40,
                            padding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text("生年月日"),
                                  ],
                                ),
                                IconButton(
                                  onPressed: () {
                                    context.go(PagePath.notification);
                                  },
                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                    color: BrandColor.baseRed,
                                  ),
                                  iconSize: 24,
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
            //
            // サービス
            //
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "サービス",
                  ),
                ),
                Container(
                    decoration: BoxDecoration(
                      color: BrandColor.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Container(
                            height: 40,
                            padding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.textsms,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text("ご意見・お問い合わせ"),
                                  ],
                                ),
                                IconButton(
                                  onPressed: () {
                                    context.go(PagePath.notification);
                                  },
                                  icon: Icon(
                                    Icons.north_east,
                                    color: BrandColor.baseRed,
                                  ),
                                  iconSize: 24,
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.black,
                            height: 4,
                            indent: 8,
                            endIndent: 8,
                          ),
                          Container(
                            height: 40,
                            padding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.assignment,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text("規約"),
                                  ],
                                ),
                                IconButton(
                                  onPressed: () {
                                    context.go(PagePath.notification);
                                  },
                                  icon: Icon(
                                    Icons.north_east,
                                    color: BrandColor.baseRed,
                                  ),
                                  iconSize: 24,
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.black,
                            height: 4,
                            indent: 8,
                            endIndent: 8,
                          ),
                          Container(
                            height: 40,
                            padding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.error,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text("プライバシーポリシー"),
                                  ],
                                ),
                                IconButton(
                                  onPressed: () {
                                    context.go(PagePath.notification);
                                  },
                                  icon: Icon(
                                    Icons.north_east,
                                    color: BrandColor.baseRed,
                                  ),
                                  iconSize: 24,
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.black,
                            height: 4,
                            indent: 8,
                            endIndent: 8,
                          ),
                          Container(
                            height: 40,
                            padding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.logout,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text("ログアウト"),
                                  ],
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
            //
            //アカウント削除
            //
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    decoration: BoxDecoration(
                      color: BrandColor.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Container(
                              alignment: Alignment.center,
                              height: 40,
                              padding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 8.0),
                              child: Text("アカウント削除")),
                        ],
                      ),
                    ))
              ],
            ),
            // button,
            // ElevatedButton(
            //   onPressed: () async {
            //     LocalNotificationService().showNotification();
            //   },
            //   child: const Text("今すぐ通知"),
            // ),
          ],
        ),
      ),
    );

    return drawer;
  }
}
