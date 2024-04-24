class UpdateInfoEntity {
  final String latestVersion;
  final String requiredVersion;
  final DateTime enabledAt;

  UpdateInfoEntity({
    required this.latestVersion,
    required this.requiredVersion,
    required this.enabledAt,
  });
}
