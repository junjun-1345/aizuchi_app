import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:aizuchi_app/presentation/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StartPage extends HookConsumerWidget {
  const StartPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    //     FlutterLocalNotificationsPlugin();

    // Future<void> _requestPermissions() async {
    //   if (Platform.isIOS || Platform.isMacOS) {
    //     await flutterLocalNotificationsPlugin
    //         .resolvePlatformSpecificImplementation<
    //             IOSFlutterLocalNotificationsPlugin>()
    //         ?.requestPermissions(
    //           alert: true,
    //           badge: true,
    //           sound: true,
    //         );
    //     await flutterLocalNotificationsPlugin
    //         .resolvePlatformSpecificImplementation<
    //             MacOSFlutterLocalNotificationsPlugin>()
    //         ?.requestPermissions(
    //           alert: true,
    //           badge: true,
    //           sound: true,
    //         );
    //   } else if (Platform.isAndroid) {
    //     final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
    //         flutterLocalNotificationsPlugin
    //             .resolvePlatformSpecificImplementation<
    //                 AndroidFlutterLocalNotificationsPlugin>();
    //     await androidImplementation?.requestPermission();
    //   }
    // }

    final signUpButton = RegisterButton(
      onPressed: () {
        context.go(PagePath.signUp);
      },
      text: '新規登録',
    );

    final signInButton = RegisterButton(
      onPressed: () {
        context.go(PagePath.signIn);
      },
      text: 'ログイン',
    );

    //////////////////////
    // レイアウトの構成
    //////////////////////
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        alignment: Alignment.center,
        child: SizedBox(
          width: screenWidth * 0.8,
          child: Column(
            children: [
              Image.asset('assets/images/AIzuchiLogo.png'),
              const SizedBox(
                height: 104,
              ),
              signUpButton,
              const SizedBox(
                height: 16,
              ),
              Text("既に登録済みの方はこちら"),
              signInButton,
              TextButton(
                onPressed: () {
                  context.go(PagePath.passwordReset);
                },
                child: Text("パスワードを忘れた方"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
