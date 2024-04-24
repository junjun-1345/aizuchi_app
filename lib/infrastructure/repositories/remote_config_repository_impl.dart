import 'dart:convert';

import 'package:aizuchi_app/domain/entity/enums/update.dart';
import 'package:aizuchi_app/domain/repositories/remote_config.dart';
import 'package:aizuchi_app/infrastructure/models/update.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:version/version.dart';

const flavor = String.fromEnvironment('flavor');

class RemoteConfigRepositoryImpl implements RemoteConfigRepository {
  static final rc = FirebaseRemoteConfig.instance;
  @override
  Future<void> congigFRC() async {
    const Duration interval =
        flavor == "dev" ? Duration.zero : Duration(hours: 1);

    await rc.setConfigSettings(
      RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: interval),
    );

    try {
      await rc.fetchAndActivate();
    } catch (e) {
      print("Failed to fetch and activate: $e");
    }
  }

  @override
  Future<UpdateRequestType> updateRequest(
      String? cancelledUpdateDateTime) async {
    final string = rc.getString('update_info');
    if (string.isEmpty) {
      return UpdateRequestType.not;
    }

    final map = json.decode(string) as Map<String, Object?>;
    final updateInfo = UpdateInfo.fromJson(map);

    // 現在のアプリケーションを取得
    final packageInfo = await PackageInfo.fromPlatform();
    final appVersion = Version.parse(packageInfo.version);
    final latestVersion = Version.parse(updateInfo.latestVersion);
    final requiredVersion = Version.parse(updateInfo.requiredVersion);
    final enabledAt = updateInfo.enabledAt;

    print("appVersion: $appVersion");
    print("latestVersion: $latestVersion");
    print("requiredVersion: $requiredVersion");

    // 現在のバージョンより新しいバージョンが指定されているか
    final hasNewVersion =
        latestVersion > appVersion || requiredVersion > appVersion;

    // ダイアログ表示が有効かどうか
    late bool isEnabled;
    if (enabledAt.isBefore(DateTime.now())) {
      isEnabled = cancelledUpdateDateTime == null ||
          enabledAt.isAfter(DateTime.parse(cancelledUpdateDateTime));
    } else {
      isEnabled = false;
    }

    if (!isEnabled || !hasNewVersion) {
      return UpdateRequestType.not;
    }
    return latestVersion > appVersion && requiredVersion <= appVersion
        ? UpdateRequestType.cancelable
        : UpdateRequestType.forcibly;
  }
}
