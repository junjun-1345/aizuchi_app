import 'package:purchases_flutter/purchases_flutter.dart';

enum PlanType {
  weekly,
  monthly,
  annual,
}

extension PlanExtension on PackageType {
  PlanType toPlanType() {
    switch (this) {
      case PackageType.weekly:
        return PlanType.weekly;
      case PackageType.monthly:
        return PlanType.monthly;
      case PackageType.annual:
        return PlanType.annual;
      default:
        throw Exception('Unsupported ColorEnum value');
    }
  }
}

extension PackageTypeExtension on PlanType {
  PackageType toPackageType() {
    switch (this) {
      case PlanType.weekly:
        return PackageType.weekly;
      case PlanType.monthly:
        return PackageType.monthly;
      case PlanType.annual:
        return PackageType.annual;
      default:
        throw Exception('Unsupported ColorEnum value');
    }
  }
}
