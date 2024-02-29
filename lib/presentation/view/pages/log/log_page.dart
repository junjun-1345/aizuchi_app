import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

@RoutePage()
class LogPage extends StatelessWidget {
  const LogPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> signOut() async {
      await FirebaseAuth.instance.signOut();
      context.router.replace(const SignInRoute());
      // final authenticated = FirebaseAuth.instance.currentUser != null;
      // print(authenticated);
    }

    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('MessagePage'),
          const Text("もふもふ", style: TextStyle(fontSize: 80)),
          const Text("LOGIN", style: TextStyle(fontSize: 80)),
          ElevatedButton(
            onPressed: () {
              signOut();
            },
            child: const Text('LOGOUT'),
          ),
          ElevatedButton(
            onPressed: () {
              signOut();
            },
            child: const Text('LOGOUT'),
          ),
        ],
      ),
    );
  }
}
