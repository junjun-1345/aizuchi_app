import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:aizuchi_app/presentation/state/user_state.dart';
import 'package:aizuchi_app/presentation/view/components/app_appbar.dart';
import 'package:aizuchi_app/presentation/view/components/app_loading.dart';
import 'package:aizuchi_app/presentation/view/components/drawer_content.dart';
import 'package:aizuchi_app/presentation/view/pages/message/components/message_contents.dart';
import 'package:aizuchi_app/presentation/view/pages/message/components/message_emotion_select_dialog.dart';
import 'package:aizuchi_app/presentation/view/pages/message/components/message_footer_contents.dart';
import 'package:aizuchi_app/presentation/view/pages/message/components/message_overlimit_dialog.dart';
import 'package:aizuchi_app/presentation/view_model/message_view_model.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class MessagePage extends HookConsumerWidget {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersState = ref.watch(usersNotifierProvider);
    final isMessageOverLimitDialog = useState(false);
    final datetimeNow = DateTime.now();
    final today = "${datetimeNow.year}_${datetimeNow.month}_${datetimeNow.day}";

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        drawer: const HamburgerMenu(),
        drawerScrimColor: BrandColor.base,
        appBar: const AppAppBar(
          title: "もうふちゃん",
        ),
        body: usersState.when(
          data: (data) {
            data.isMessageOverLimit
                ? null
                : isMessageOverLimitDialog.value = false;
            if (data.isMessageOverLimit && !isMessageOverLimitDialog.value) {
              isMessageOverLimitDialog.value = true;
              WidgetsBinding.instance.addPostFrameCallback(
                (_) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return MessageOverLimitDialog(
                        onFunction: () {
                          ref.read(messageViewModelProvider).createSummary();
                        },
                      );
                    },
                  );
                },
              );
            }
            if (!data.isConversation && data.dailyKey != today) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showDialog(
                  context: context,
                  builder: (context) => MessageEmotionSelectDailog(
                    dailyKey: data.dailyKey,
                  ),
                );
              });
            }
            return const Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MessageContents(),
                MessageFooterContents(),
              ],
            );
          },
          loading: () {
            return const AppLoading();
          },
          error: (Object error, StackTrace stackTrace) {
            return const Text("エラーが発生しました");
          },
        ),
      ),
    );
  }
}
