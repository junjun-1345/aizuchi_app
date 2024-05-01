import 'package:aizuchi_app/domain/domain_module.dart';
import 'package:aizuchi_app/domain/entity/enums/update.dart';
import 'package:aizuchi_app/domain/entity/models/color.dart';

import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:aizuchi_app/presentation/state/user_state.dart';
import 'package:aizuchi_app/presentation/view/components/update_dialog.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class RootPage extends HookConsumerWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersNotifier = ref.watch(usersNotifierProvider);
    final updateRequest =
        ref.watch(remoteConfigUsecaseProvider).updateRequest();

    final isDialogShowing = useState(false);

    return AutoTabsRouter(
      routes: const [
        CalenderRoute(),
        LogRoute(),
        MessageRoute(),
        MeasurementRoute(),
        SearchRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = context.tabsRouter;
        return usersNotifier.when(
          data: (data) {
            updateRequest.then(
              (updateRequestTypeValue) {
                if (!isDialogShowing.value &&
                    (updateRequestTypeValue == UpdateRequestType.cancelable ||
                        updateRequestTypeValue == UpdateRequestType.forcibly)) {
                  isDialogShowing.value = true;
                  showDialog(
                    context: context,
                    builder: (context) => UpdatePromptDialog(
                      updateRequestType: updateRequestTypeValue,
                    ),
                  ).then((_) => isDialogShowing.value = false);
                }
              },
            );
            return Scaffold(
              body: child,
              backgroundColor: BrandColor.baseDark,
              bottomNavigationBar: NavigationBar(
                surfaceTintColor: Colors.transparent,
                backgroundColor: Colors.white,
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
                      Icons.history,
                      color: BrandColor.baseRed,
                    ),
                    selectedIcon: Icon(
                      Icons.history,
                      color: BrandColor.white,
                    ),
                    label: 'きろく',
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
                      Icons.psychology_alt,
                      color: BrandColor.baseRed,
                    ),
                    selectedIcon: Icon(
                      Icons.psychology_alt,
                      color: BrandColor.white,
                    ),
                    label: 'そくてい',
                  ),
                  NavigationDestination(
                    icon: Icon(
                      Icons.search,
                      color: BrandColor.baseRed,
                    ),
                    selectedIcon: Icon(
                      Icons.search,
                      color: BrandColor.white,
                    ),
                    label: 'しらべる',
                  ),
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
