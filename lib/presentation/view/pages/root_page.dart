import 'package:aizuchi_app/domain/domain_module.dart';
import 'package:aizuchi_app/domain/entity/enums/update.dart';
import 'package:aizuchi_app/domain/entity/models/color.dart';

import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:aizuchi_app/presentation/state/user_state.dart';
import 'package:aizuchi_app/presentation/view/components/app_dialog.dart';
import 'package:aizuchi_app/presentation/view_model/message_view_model.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
                if (!isDialogShowing.value &&
                    (updateRequestTypeValue == UpdateRequestType.cancelable ||
                        updateRequestTypeValue == UpdateRequestType.forcibly)) {
                  isDialogShowing.value = true;

                  // FIXME: 挙動が不安定
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
                    icon: FaIcon(
                      FontAwesomeIcons.calendar,
                      color: BrandColor.baseRed,
                    ),
                    selectedIcon: FaIcon(
                      FontAwesomeIcons.calendar,
                      color: BrandColor.white,
                    ),
                    label: 'カレンダー',
                  ),
                  NavigationDestination(
                    icon: FaIcon(
                      FontAwesomeIcons.chartSimple,
                      color: BrandColor.baseRed,
                    ),
                    selectedIcon: FaIcon(
                      FontAwesomeIcons.chartSimple,
                      color: BrandColor.white,
                    ),
                    label: 'きろく',
                  ),
                  NavigationDestination(
                    icon: FaIcon(
                      FontAwesomeIcons.comment,
                      color: BrandColor.baseRed,
                    ),
                    selectedIcon: FaIcon(
                      FontAwesomeIcons.comment,
                      color: BrandColor.white,
                    ),
                    label: 'チャット',
                  ),
                  NavigationDestination(
                    icon: FaIcon(
                      FontAwesomeIcons.heartPulse,
                      color: BrandColor.baseRed,
                    ),
                    selectedIcon: FaIcon(
                      FontAwesomeIcons.heartPulse,
                      color: BrandColor.white,
                    ),
                    label: 'そくてい',
                  ),
                  NavigationDestination(
                    icon: FaIcon(
                      FontAwesomeIcons.compass,
                      color: BrandColor.baseRed,
                    ),
                    selectedIcon: FaIcon(
                      FontAwesomeIcons.compass,
                      color: BrandColor.white,
                    ),
                    label: 'しらべる',
                  ),
                ],
                onDestinationSelected: (index) {
                  if (!data.isConversation) {
                    tabsRouter.setActiveIndex(index);
                  } else {
                    AppDialog.showCheckDialog(
                      context: context,
                      title: '会話中は他の画面に\n移動できません',
                      onCompleted: () {
                        ref.read(messageViewModelProvider).createSummary();
                      },
                      content: '会話を終了しますか？',
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
