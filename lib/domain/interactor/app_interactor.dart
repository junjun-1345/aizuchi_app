import 'package:aizuchi_app/domain/entity/enums/plan.dart';
import 'package:aizuchi_app/domain/entity/enums/shared_preferences_key.dart';
import 'package:aizuchi_app/domain/entity/enums/update.dart';
import 'package:aizuchi_app/domain/entity/models/plan_model.dart';
import 'package:aizuchi_app/domain/entity/models/subscription_model.dart';
import 'package:aizuchi_app/domain/repositories/local_notification_repository.dart';
import 'package:aizuchi_app/domain/repositories/purchases_flutter_repository.dart';
import 'package:aizuchi_app/domain/repositories/remote_config.dart';
import 'package:aizuchi_app/domain/repositories/shared_preferences_repository.dart';
import 'package:aizuchi_app/domain/repositories/user_db_repository.dart';
import 'package:aizuchi_app/domain/usecases/app_usecase.dart';

class AppInteractor implements AppUsecase {
  final UserDBRepository userRepository;
  final PurchasesFlutterRepository purchasesFlutterRepository;
  final RemoteConfigRepository remoteConfigRepository;
  final SharedPreferencesRepository sharedPreferencesRepository;
  final LocalNotificationRepository localNotificationRepository;

  AppInteractor(
    this.userRepository,
    this.purchasesFlutterRepository,
    this.remoteConfigRepository,
    this.sharedPreferencesRepository,
    this.localNotificationRepository,
  );
  @override
  Future<void> initializeAppInfrastructure() async {
    await remoteConfigRepository.initializeFRC();
    await purchasesFlutterRepository.initializePurchasesFlutter();
    await localNotificationRepository.initializeNotifications();
  }

  // remoteConfig関連
  @override
  Future<UpdateRequestType> updateRequest() async {
    final cancelledUpdateDateTime = await sharedPreferencesRepository
        .fetch<String>(SharedPreferencesKey.cancelledUpdateDateTime);
    return await remoteConfigRepository.updateRequest(cancelledUpdateDateTime);
  }

  // 課金関連
  @override
  Future<SubscriptionModel> checkSubscriptionStatus() async {
    return await purchasesFlutterRepository.checkSubscriptionStatus();
  }

  @override
  Future<List<Plan>> getSubscriptionPackages() async {
    return await purchasesFlutterRepository.getPackages();
  }

  @override
  Future<bool> purchaseSubscriptionPackage(PlanType planType) async {
    return await purchasesFlutterRepository.purchasePackage(planType);
  }

  @override
  Future<bool> restorePurchase() async {
    return await purchasesFlutterRepository.restorePurchase();
  }

  // ローカル通知関連
  @override
  Future<void> scheduleDailyNotificationAt(int hour, int minute) async {
    // 通知を全てキャンセルしてから新しい通知をスケジュールする
    await cancelAllNotifications();

    String timeValue = "$hour:$minute";
    await sharedPreferencesRepository.save<String>(
        SharedPreferencesKey.scheduleDailyNotificationTime, timeValue);
    return await localNotificationRepository.scheduleDailyNotificationAt(
        hour, minute);
  }

  @override
  Future<Map<String, int>> readNotifications() async {
    String? timeValue = await sharedPreferencesRepository
        .fetch<String>(SharedPreferencesKey.scheduleDailyNotificationTime);
    if (timeValue != null) {
      List<String> parts = timeValue.split(':');
      int hour = int.parse(parts[0]);
      int minute = int.parse(parts[1]);
      return {'hour': hour, 'minute': minute};
    } else {
      return {'hour': 00, 'minute': 00};
    }
  }

  @override
  Future<void> cancelAllNotifications() async {
    await sharedPreferencesRepository
        .remove(SharedPreferencesKey.scheduleDailyNotificationTime);
    return await localNotificationRepository.cancelAllNotifications();
  }

  @override
  Future<bool> checkNotificationPermission() {
    return localNotificationRepository.checkNotificationPermission();
  }
}
