import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:aizuchi_app/presentation/view/components/completed_dialog.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class PlanButton extends StatelessWidget {
  const PlanButton(this.child, this.onTap,
      {this.isBorder = false,
      this.isBaclground = false,
      this.height = 80,
      this.alignment = MainAxisAlignment.center,
      Key? key})
      : super(key: key);

  final Widget child;
  final VoidCallback onTap;
  final bool isBorder;
  final bool isBaclground;
  final double height;
  final MainAxisAlignment alignment;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.black.withOpacity(0.2),
        highlightColor: Colors.black.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        child: Ink(
          decoration: BoxDecoration(
            color: isBaclground ? BrandColor.baseRed : BrandColor.white,
            borderRadius: BorderRadius.circular(8),
            border: isBorder
                ? Border.all(
                    color: BrandColor.baseRed,
                    width: 2,
                  )
                : null,
          ),
          height: height,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: child,
        ),
      ),
    );
  }
}
