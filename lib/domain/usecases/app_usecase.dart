import 'package:aizuchi_app/domain/entity/enums/plan.dart';
import 'package:aizuchi_app/domain/entity/enums/update.dart';
import 'package:aizuchi_app/domain/entity/models/plan_model.dart';
import 'package:aizuchi_app/domain/entity/models/subscription_model.dart';

abstract class AppUsecase {
  Future<void> initializeAppInfrastructure();
  Future<UpdateRequestType> updateRequest();
  Future<List<Plan>> getSubscriptionPackages();
  Future<bool> purchaseSubscriptionPackage(PlanType planType);
  Future<bool> restorePurchase();
  Future<SubscriptionModel> checkSubscriptionStatus();
  Future<void> scheduleDailyNotificationAt(int hour, int minute);
  Future<Map<String, int>> readNotifications();
  Future<void> cancelAllNotifications();
  Future<bool> checkNotificationPermission();
}
