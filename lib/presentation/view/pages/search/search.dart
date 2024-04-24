import 'package:aizuchi_app/domain/entity/enums/shared_preferences_key.dart';
import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:aizuchi_app/infrastructure/data_model.dart';
import 'package:aizuchi_app/presentation/view/components/app_button.dart';
import 'package:aizuchi_app/presentation/view/components/drawer_content.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        body: Center(
          child: Column(
            children: [
              Text("調べる"),
              AppButton.medium(
                onPressed: () async {
                  final remoteConfig = FirebaseRemoteConfig.instance;
                  await remoteConfig.setConfigSettings(
                    RemoteConfigSettings(
                      fetchTimeout: const Duration(minutes: 1),
                      minimumFetchInterval: const Duration(hours: 1),
                    ),
                  );
                  await remoteConfig.setDefaults(
                    const {
                      "example_param_1": 42,
                      "example_param_2": 3.14159,
                      "example_param_3": true,
                      "example_param_4": "Hello, Flutter!",
                    },
                  );
                },
                text: "イニシャライズ",
              ),
              AppButton.medium(
                onPressed: () async {
                  try {
                    final FirebaseRemoteConfig remoteConfig =
                        FirebaseRemoteConfig.instance;
                    // Using zero duration to force fetching from remote server.
                    await remoteConfig.setConfigSettings(
                      RemoteConfigSettings(
                        fetchTimeout: const Duration(seconds: 10),
                        minimumFetchInterval: Duration.zero,
                      ),
                    );
                    await remoteConfig.fetchAndActivate();
                    print(
                        'Fetched: ${remoteConfig.getString("example_param_1")}');
                  } on PlatformException catch (exception) {
                    // Fetch exception.
                    print('Exception: $exception');
                  } catch (exception) {
                    print(exception);
                    print(
                        'Unable to fetch remote config. Cached or default values will be '
                        'used');
                  }
                },
                text: "ゲット example_param_1",
              ),
              AppButton.medium(
                onPressed: () async {
                  try {
                    final FirebaseRemoteConfig remoteConfig =
                        FirebaseRemoteConfig.instance;
                    // Using zero duration to force fetching from remote server.
                    await remoteConfig.setConfigSettings(
                      RemoteConfigSettings(
                        fetchTimeout: const Duration(seconds: 10),
                        minimumFetchInterval: Duration.zero,
                      ),
                    );
                    await remoteConfig.fetchAndActivate();
                    print(
                        'Fetched: ${remoteConfig.getString("example_param_4")}');
                  } on PlatformException catch (exception) {
                    // Fetch exception.
                    print('Exception: $exception');
                  } catch (exception) {
                    print(exception);
                    print(
                        'Unable to fetch remote config. Cached or default values will be '
                        'used');
                  }
                },
                text: "ゲット example_param_4",
              ),
              AppButton.medium(
                onPressed: () async {
                  ref
                      .read(sharedPreferencesProvider)
                      .remove(SharedPreferencesKey.cancelledUpdateDateTime);
                },
                text: "キャンセル日時削除　",
              ),
              AppButton.small(onPressed: () {}, text: "戻る")
            ],
          ),
        ));
  }
}
