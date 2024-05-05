import 'package:aizuchi_app/domain/domain_module.dart';
import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:aizuchi_app/presentation/view/components/app_button.dart';
import 'package:aizuchi_app/presentation/view/pages/settings/components/list_item.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class NotificationPage extends ConsumerWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifications = ref.read(appUsecaseProvider).readNotifications();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "通知設定",
          style: TextStyle(color: BrandColor.black),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: BrandColor.textBlack),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: FutureBuilder(
            future: notifications,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return const Text('An error has occurred!');
              } else if (!snapshot.hasData) {
                return const Text('An error has occurred!');
              } else {
                final data = snapshot.data as Map<String, int>;
                final hour = data["hour"];
                final minute = data["minute"];

                String formattedHour = _formatTwoDigits(hour ?? 00);
                String formattedMinute = _formatTwoDigits(minute ?? 00);

                return FutureBuilder(
                  future: ref
                      .read(appUsecaseProvider)
                      .checkNotificationPermission(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return const Text('An error has occurred!');
                    } else if (!snapshot.hasData) {
                      return const Text('An error has occurred!');
                    }
                    final hasPermission = snapshot.data ?? false;
                    return Column(
                      children: [
                        const SizedBox(height: 48),
                        hasPermission
                            ? ListItem(
                                title: "時間",
                                value: "$formattedHour:$formattedMinute",
                                onTap: () {
                                  _showTimePickerDialog(context, ref, 20, 00);
                                },
                              )
                            : const SizedBox(),
                        const SizedBox(height: 24),
                        ListItem(
                          title: "通知の許可",
                          value: hasPermission ? "許可済" : "未許可",
                          onTap: () {
                            null;
                          },
                        ),
                        const SizedBox(height: 24),
                        hasPermission
                            ? AppButton.medium(
                                text: "通知をOFFにする",
                                onPressed: () {
                                  ref
                                      .read(appUsecaseProvider)
                                      .cancelAllNotifications();
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title: const Text("通知設定"),
                                            content:
                                                const Text("通知をOFFに変更しました。"),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  context.router.replace(
                                                      const MessageRoute());
                                                },
                                                child: const Text(
                                                  'OK',
                                                  style: TextStyle(
                                                      color:
                                                          BrandColor.baseRed),
                                                ),
                                              ),
                                            ],
                                          ));
                                })
                            : AppButton.medium(
                                text: "通知を許可する",
                                onPressed: () {
                                  openAppNotificationSettings(context);
                                },
                              ),
                        const SizedBox(height: 24),
                      ],
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Future<void> openAppNotificationSettings(BuildContext context) async {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      const url = 'app-settings:';
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        print("設定ページを開くことができません。");
      }
    } else {
      openAppSettings();
    }
  }

  Future<void> _showTimePickerDialog(
    BuildContext context,
    WidgetRef ref,
    int initialHour,
    int initialMinute,
  ) async {
    final DateTime? pickedTime = await DatePicker.showTimePicker(context,
        showTitleActions: true, showSecondsColumn: false, onConfirm: (date) {
      return date;
    }, currentTime: DateTime.now(), locale: LocaleType.jp);

    if (pickedTime != null) {
      ref
          .read(appUsecaseProvider)
          .scheduleDailyNotificationAt(pickedTime.hour, pickedTime.minute);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("通知設定"),
          content: const Text("通知設定を変更しました。"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                context.router.replace(const MessageRoute());
              },
              child: const Text(
                'OK',
                style: TextStyle(color: BrandColor.baseRed),
              ),
            ),
          ],
        ),
      );
    }
  }

  String _formatTwoDigits(int number) {
    return number.toString().padLeft(2, '0');
  }
}
