import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:aizuchi_app/presentation/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StartPage extends HookConsumerWidget {
  const StartPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final signUpButton = Button(
    //   onPressed: () async {
    //     final service = AuthService();
    //     await service.signInWithGoogle().catchError(
    //       (e, __) {
    //         errorMessage = e.toString();
    //       },
    //     );
    //     Navigator.of(context).push(
    //       MaterialPageRoute(
    //         builder: (context) => const SignUpNamePage(),
    //       ),
    //     );
    //   },
    //   text: 'サインアップ',
    // );

    // final signInButton = Button(
    //   onPressed: () async {
    //     final service = AuthService();
    //     await service.signInWithGoogle().catchError(
    //       (e, __) {
    //         errorMessage = e.toString();
    //       },
    //     );
    //   },
    //   text: 'サインイン',
    // );

    final screenWidth = MediaQuery.of(context).size.width;

    final _testButton = Button(
        onPressed: () {
          context.go(PagePath.chat);
        },
        text: "チャットページ");

    /// 画面全体
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'サインイン画面',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: SizedBox(
          width: screenWidth * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [_testButton],
          ),
        ),
      ),
    );
  }
}
