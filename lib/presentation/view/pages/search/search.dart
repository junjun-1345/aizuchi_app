import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:aizuchi_app/presentation/view/components/drawer_content.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class SearchPage extends HookConsumerWidget {
  const SearchPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        drawer: const HamburgerMenu(),
        drawerScrimColor: BrandColor.base,
        appBar: AppBar(
          title: const Text(
            "調べる",
            style: TextStyle(fontSize: 20, color: BrandColor.textBlack),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: BrandColor.textBlack),
        ),
        body: const Center(
          child: Column(
            children: [
              Text("調べる"),
            ],
          ),
        ));
  }
}