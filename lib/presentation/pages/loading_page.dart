import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoadingPage extends HookConsumerWidget {
  const LoadingPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        child: const SizedBox(
            width: 48, height: 48, child: CircularProgressIndicator()),
      ),
    );
  }
}
