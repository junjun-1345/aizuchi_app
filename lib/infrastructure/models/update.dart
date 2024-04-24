import 'package:aizuchi_app/domain/entity/models/update.dart';

class UpdateInfo {
  final String latestVersion;
  final String requiredVersion;
  final DateTime enabledAt;

  UpdateInfo({
    required this.latestVersion,
    required this.requiredVersion,
    required this.enabledAt,
  });

  factory UpdateInfo.fromJson(Map<String, dynamic> json) {
    return UpdateInfo(
      latestVersion: json['latestVersion'],
      requiredVersion: json['requiredVersion'],
      enabledAt: DateTime.parse(json['enabledAt']),
    );
  }

  static UpdateInfo fromEntity(UpdateInfoEntity entity) => UpdateInfo(
        latestVersion: entity.latestVersion,
        requiredVersion: entity.requiredVersion,
        enabledAt: entity.enabledAt,
      );

  UpdateInfoEntity toEntity() => UpdateInfoEntity(
        latestVersion: latestVersion,
        requiredVersion: requiredVersion,
        enabledAt: enabledAt,
      );
}
