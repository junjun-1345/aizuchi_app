import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:flutter/material.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;

  const AppAppBar({super.key, this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title ?? "",
        style: const TextStyle(
          fontSize: 16,
          color: BrandColor.textBlack,
          fontWeight: FontWeight.bold,
        ),
      ),
      elevation: 0,
      backgroundColor: BrandColor.base,
      iconTheme: const IconThemeData(color: BrandColor.textBlack),
      scrolledUnderElevation: 0.0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
