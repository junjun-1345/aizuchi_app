import 'dart:convert';

import 'package:aizuchi_app/domain/entity/enums/update.dart';
import 'package:aizuchi_app/domain/repositories/remote_config.dart';
import 'package:aizuchi_app/domain/utils/string_utils.dart';
import 'package:aizuchi_app/infrastructure/enums/remote_config_key.dart';
import 'package:aizuchi_app/infrastructure/models/update.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:version/version.dart';

const flavor = String.fromEnvironment('flavor');

class RemoteConfigRepositoryImpl implements RemoteConfigRepository {
  static final rc = FirebaseRemoteConfig.instance;
  @override
  Future<void> initializeFRC() async {
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
      throw ("Failed to fetch and activate: $e");
    }
  }

  @override
  Future<UpdateRequestType> updateRequest(
      String? cancelledUpdateDateTime) async {
    final string =
        rc.getString(RemoteConfigKey.updateInfo.name.camelToSnakeCase);
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

    // 現在のバージョンより新しいバージョンが指定されているか
    final hasNewVersion =
        latestVersion > appVersion || requiredVersion > appVersion;

    // ダイアログ表示が有効かどうか
    late bool isEnabled;
    isEnabled = isUpdateEnabled(enabledAt, cancelledUpdateDateTime);

    if (!isEnabled || !hasNewVersion) {
      return UpdateRequestType.not;
    }
    return latestVersion > appVersion && requiredVersion <= appVersion
        ? UpdateRequestType.cancelable
        : UpdateRequestType.forcibly;
  }

  @override
  Future<T?> fetch<T>(RemoteConfigKey key) async {
    if (T.toString() == 'int') {
      return rc.getInt(key.name.camelToSnakeCase) as T?;
    }
    if (T.toString() == 'double') {
      return rc.getDouble(key.name.camelToSnakeCase) as T?;
    }
    if (T.toString() == 'bool') {
      return rc.getBool(key.name.camelToSnakeCase) as T?;
    }
    if (T.toString() == 'String') {
      return rc.getString(key.name.camelToSnakeCase) as T?;
    } else {
      return rc.getValue(key.name.camelToSnakeCase) as T?;
    }
  }

  bool isUpdateEnabled(DateTime enabledAt, String? cancelledUpdateDateTime) {
    final now = DateTime.now();
    final isPastEnabledDate = enabledAt.isBefore(now);
    final hasNotCancelledUpdate = cancelledUpdateDateTime == null;
    final isCancelledBeforeEnabled = cancelledUpdateDateTime != null &&
        enabledAt.isAfter(DateTime.parse(cancelledUpdateDateTime));

    return isPastEnabledDate &&
        (hasNotCancelledUpdate || isCancelledBeforeEnabled);
  }
}
