import 'package:aizuchi_app/domain/entity/model/color.dart';
import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [CalenderRoute(), ChatRoute(), LogRoute()],
      builder: (context, child) {
        final tabsRouter = context.tabsRouter;
        return Scaffold(
          body: child,
          //TODO_カラーを変更する
          backgroundColor: BrandColor.baseDark,
          bottomNavigationBar: NavigationBar(
            backgroundColor: BrandColor.white,
            indicatorColor: BrandColor.baseRed,
            selectedIndex: tabsRouter.activeIndex,
            height: 56,
            destinations: const [
              NavigationDestination(
                icon: Icon(
                  Icons.calendar_month,
                  color: BrandColor.baseRed,
                ),
                selectedIcon: Icon(
                  Icons.calendar_month,
                  color: BrandColor.white,
                ),
                label: 'カレンダー',
              ),
              NavigationDestination(
                icon: Icon(
                  Icons.chat_rounded,
                  color: BrandColor.baseRed,
                ),
                selectedIcon: Icon(
                  Icons.chat_rounded,
                  color: BrandColor.white,
                ),
                label: 'チャット',
              ),
              NavigationDestination(
                icon: Icon(
                  Icons.history,
                  color: BrandColor.baseRed,
                ),
                selectedIcon: Icon(
                  Icons.history,
                  color: BrandColor.white,
                ),
                label: 'ログ',
              )
            ],
            onDestinationSelected: tabsRouter.setActiveIndex,
          ),
        );
      },
    );
  }
}
