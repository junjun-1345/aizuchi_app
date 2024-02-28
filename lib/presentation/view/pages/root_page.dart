import 'package:aizuchi_app/domain/entity/models/color.dart';

import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:aizuchi_app/presentation/state/user_state.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class RootPage extends ConsumerWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersNotifier = ref.watch(usersNotifierProvider);
    return AutoTabsRouter(
      routes: const [CalenderRoute(), MessageRoute(), LogRoute()],
      builder: (context, child) {
        final tabsRouter = context.tabsRouter;
        return usersNotifier.when(
          data: (data) {
            return Scaffold(
              body: child,
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
                      Icons.message_rounded,
                      color: BrandColor.baseRed,
                    ),
                    selectedIcon: Icon(
                      Icons.message_rounded,
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
                onDestinationSelected: (index) {
                  if (!data.isConversation) {
                    tabsRouter.setActiveIndex(index);
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('アクセス制限'),
                        content: const Text('会話中は他の画面に移動できません'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text(
                              'OK',
                              style: TextStyle(color: BrandColor.baseRed),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            );
          },
          loading: () {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
          error: (error, stackTrace) {
            return const Scaffold(
              body: Center(
                child: Text('エラーが発生しました'),
              ),
            );
          },
        );
      },
    );
  }
}
