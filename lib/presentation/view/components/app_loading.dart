import 'package:flutter/material.dart';
import 'package:gif_view/gif_view.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GifView.asset(
        'assets/images/loading.gif',
        height: 200,
        width: 200,
        frameRate: 30,
      ),
    );
  }
}
