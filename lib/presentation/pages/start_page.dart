import 'package:aizuchi_app/application/di/usecase.dart';
import 'package:aizuchi_app/presentation/dialog/dialog_widget.dart';
import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:aizuchi_app/presentation/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StartPage extends HookConsumerWidget {
  const StartPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usecase = ref.read(accountUsecaseProvider);

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

    final signUpButton = ButtonLarge(
      onPressed: () {
        usecase.signUpValidation(
          errorDialog: () {
            showErrorDialog(context, "既に登録されています");
          },
          context: context,
        );
        context.go(PagePath.singupName);
      },
      text: '新規登録',
    );

    final signInButton = ButtonLarge(
      onPressed: () {
        usecase.signInValidation(errorDialog: () {
          showErrorDialog(context, "未だ登録が完了していません");
        });
        context.go(PagePath.chat);
      },
      text: 'ログイン',
    );

    final screenWidth = MediaQuery.of(context).size.width;

    final img = Image.asset('assets/images/AIzuchiLogo.png');

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
              img,
              const SizedBox(
                height: 132,
              ),
              signUpButton,
              const SizedBox(
                height: 16,
              ),
              signInButton
            ],
          ),
        ),
      ),
    );
  }
}
