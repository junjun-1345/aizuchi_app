import 'package:aizuchi_app/domain/entity/enums/plan.dart';
import 'package:aizuchi_app/domain/entity/models/plan_model.dart';
import 'package:aizuchi_app/domain/entity/models/subscription_model.dart';

abstract class PurchasesFlutterRepository {
  Future<void> configureSDK();
  Future<List<Plan>> getPackages();
  Future<bool> purchasePackage(PlanType planType);
  Future<bool> restorePurchase();
  Future<SubscriptionModel> checkSubscriptionStatus();
}
