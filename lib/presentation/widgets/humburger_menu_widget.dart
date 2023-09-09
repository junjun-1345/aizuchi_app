import 'package:aizuchi_app/infrastructure/firebase/auth_imp.dart';
import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:aizuchi_app/presentation/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/colors.dart';

class HumburgerMenu extends StatelessWidget {
  const HumburgerMenu({super.key});

  @override
  Widget build(BuildContext context) {
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
            await service.signOutWithGoogle().catchError(
              (e) {
                debugPrint('サインアウトできませんでした $e');
              },
            );
            context.go(PagePath.start);
          },
          text: 'サインアウト',
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
