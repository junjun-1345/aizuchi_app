import 'package:flutter/material.dart';

class SelectWeekPart extends StatelessWidget {
  const SelectWeekPart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 25,
            width: 25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                width: 1,
                color: const Color(0xffe79f95),
              ),
            ),
            child: const Icon(
              Icons.navigate_before,
              color: Color(0xffe79f95),
            ),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        const Text(
          '1/13(水) 〜 1/19(火)',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xffe79f95),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 25,
            width: 25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                width: 1,
                color: const Color(0xffe79f95),
              ),
            ),
            child: const Icon(
              Icons.navigate_next,
              color: Color(0xffe79f95),
            ),
          ),
        ),
      ],
    );
  }
}