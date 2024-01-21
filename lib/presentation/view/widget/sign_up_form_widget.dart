import 'package:aizuchi_app/domain/entity/model/color.dart';
import 'package:aizuchi_app/presentation/view/widget/text_widget.dart';
import 'package:flutter/material.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({
    super.key,
    required this.index,
    required this.content,
  });
  final int index;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        textTitleWidget("プロフィール"),
        const SizedBox(
          height: 48,
        ),
        Text("$index/4"),
        const SizedBox(
          height: 8,
        ),
        LinearProgressIndicator(
          value: index / 4,
          color: BrandColor.baseRed,
          backgroundColor: Colors.black12,
        ),
        const SizedBox(
          height: 24,
        ),
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text("$contentを教えてください🐑"),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 120,
              child: Image.asset('assets/images/moufu_icon_5.png'),
            ),
          ],
        ),
        const SizedBox(
          height: 56,
        ),
      ],
    );
  }
}
