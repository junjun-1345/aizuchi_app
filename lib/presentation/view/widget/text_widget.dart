import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget textTitleWidget(
  String text,
) {
  return Text(
    text,
    style: const TextStyle(
      fontSize: 24,
      letterSpacing: 2,
      fontWeight: FontWeight.w600,
    ),
  );
}
