import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:flutter/material.dart';

class AttentionDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onPressed;

  const AttentionDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            'キャンセル',
            style: TextStyle(color: BrandColor.baseRed),
          ),
        ),
        TextButton(
          onPressed: onPressed,
          child: const Text(
            'OK',
            style: TextStyle(color: BrandColor.baseRed),
          ),
        ),
      ],
    );
  }
}
