import 'package:aizuchi_app/presentation/theme/fonts.dart';
import 'package:flutter/material.dart';

import '../theme/colors.dart';

class Button extends StatelessWidget {
  const Button({super.key, required this.onPressed, required this.text});

  /// コールバック
  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: BrandColor.baseBlue,
          shape: const StadiumBorder(),
          elevation: 0,
        ),
        child: Text(text,
            style: BrandText.textButton.copyWith(color: Colors.white)),
      ),
    );
  }
}

class ButtonLarge extends StatelessWidget {
  const ButtonLarge({super.key, required this.onPressed, required this.text});

  /// コールバック
  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: BrandColor.baseBlue,
          shape: const StadiumBorder(),
          elevation: 0,
        ),
        child: Text(text,
            style: BrandText.titleBold.copyWith(color: Colors.white)),
      ),
    );
  }
}
