import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:aizuchi_app/presentation/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ErrorDialog extends ConsumerWidget {
  final String title;
  final String? content;
  const ErrorDialog({super.key, required this.title, this.content});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final error = ref.watch(errorProvider);
    return AlertDialog(
      title: Text(title),
      content: Text(content ?? error),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            ref.read(errorProvider.notifier).state = "";
            Navigator.of(context).pop();
          },
          child: const Text(
            'OK',
            style: TextStyle(color: BrandColor.baseRed),
          ),
        ),
      ],
    );
  }
}
