import 'package:aizuchi_app/domain/domain_module.dart';
import 'package:aizuchi_app/domain/entity/enums/update.dart';
import 'package:aizuchi_app/domain/entity/models/color.dart';

import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:aizuchi_app/presentation/state/user_state.dart';
import 'package:aizuchi_app/presentation/view/components/app_dialog.dart';
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
    final updateRequest = ref.watch(appUsecaseProvider).updateRequest();

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
                print("アップデート $updateRequestTypeValue");
                if (!isDialogShowing.value &&
                    (updateRequestTypeValue == UpdateRequestType.cancelable ||
                        updateRequestTypeValue == UpdateRequestType.forcibly)) {
                  isDialogShowing.value = true;
                  // showDialog(
                  //   context: context,
                  //   builder: (context) => UpdatePromptDialog(
                  //     updateRequestType: updateRequestTypeValue,
                  //   ),
                  // ).then((_) => isDialogShowing.value = false);

                  AppDialog.showUpdatePromptDialog(
                      context: context,
                      updateRequestType: updateRequestTypeValue);
                  isDialogShowing.value = false;
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
                    AppDialog.showErrorDialog(
                      context: context,
                      title: 'アクセス制限',
                      content: '会話中は他の画面に移動できません',
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
