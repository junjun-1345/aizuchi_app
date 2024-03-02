import 'package:flutter/material.dart';

class StartImage extends StatelessWidget {
  const StartImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          height: 88,
          width: 88,
          child: Image.asset('assets/images/mofumofu_icon_1.png'),
        ),
      ],
    );
  }
}
