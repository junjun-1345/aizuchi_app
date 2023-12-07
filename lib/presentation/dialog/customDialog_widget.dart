import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomDialogWidget extends StatelessWidget {
  final String message;
  final String routeName;

  const CustomDialogWidget({
    required this.message,
    required this.routeName,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('メッセージ'),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            context.go(routeName);
          },
          child: Text('戻る'),
        ),
      ],
    );
  }
}
