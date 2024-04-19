import 'dart:io';

import 'package:aizuchi_app/domain/entity/enums/plan.dart';
import 'package:aizuchi_app/domain/entity/models/plan_model.dart';
import 'package:aizuchi_app/domain/entity/models/subscription_model.dart';
import 'package:aizuchi_app/domain/repositories/purchases_flutter_repository.dart';
import 'package:aizuchi_app/env/env.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PurchasesFlutterRepositoryImpl implements PurchasesFlutterRepository {
  bool isSubscribed = false;
  late Offerings offerings;
  FirebaseAuth auth = FirebaseAuth.instance;
  static final _key = Env.revenucatProdApiKey;

  @override
  Future<void> configureSDK() async {
    await Purchases.setLogLevel(LogLevel.debug);

    late PurchasesConfiguration configuration;
    if (Platform.isAndroid) {
      // configuration = PurchasesConfiguration(Android用のRevenuecat APIキー);
    } else if (Platform.isIOS) {
      configuration = PurchasesConfiguration(_key);
    }
    await Purchases.configure(configuration);
  }

  @override
  Future<List<Plan>> getPackages() async {
    Offerings? offerings;
    try {
      offerings = await Purchases.getOfferings();
      offerings.current?.availablePackages.forEach((element) {});
      final List<Plan> planList;
      planList = offerings.current!.availablePackages
          .map(
            (e) => Plan(
              id: e.identifier,
              name: e.storeProduct.title,
              price: e.storeProduct.price.toInt(),
              planType: e.packageType.toPlanType(),
            ),
          )
          .toList();
      return planList;
    } catch (e) {
      throw Exception('データの取得中にエラーが発生しました。$e');
    }
  }

  @override
  Future<SubscriptionModel> checkSubscriptionStatus() async {
    SubscriptionModel status;
    try {
      await Purchases.logIn(auth.currentUser!.uid);
      CustomerInfo customerInfo = await Purchases.getCustomerInfo();
      //FIXME: 直書き良くないかも
      EntitlementInfo? entitlement =
          customerInfo.entitlements.all["aizuchi_premium_subscription"];

      //dev
      // EntitlementInfo? entitlement =
      //     customerInfo.entitlements.all["offering_test_a"];

      if (entitlement == null || entitlement.isActive == false) {
        status = SubscriptionModel(
          isActive: false,
          planName: null,
          expirationDate: null,
          billingIssueDetectedAt: null,
        );
        return status;
      } else {
        status = SubscriptionModel(
          isActive: entitlement.isActive,
          planName: entitlement.identifier,
          expirationDate:
              DateTime.parse(entitlement.expirationDate.toString()).toLocal(),
          billingIssueDetectedAt: entitlement.billingIssueDetectedAt != null
              ? DateTime.parse(entitlement.billingIssueDetectedAt.toString())
                  .toLocal()
              : null,
        );
        return status;
      }
    } catch (e) {
      // その他の例外が発生した場合の処理
      throw Exception('データの取得中に未知のエラーが発生しました。$e');
    }
  }

  @override
  Future<bool> purchasePackage(PlanType planType) async {
    try {
      PackageType packageType = planType.toPackageType();
      offerings = await Purchases.getOfferings();
      offerings.current!.availablePackages;

      Package package = offerings.current!.availablePackages
          .where((element) => element.packageType == packageType)
          .first;
      CustomerInfo customerInfo = await Purchases.purchasePackage(package);

      //FIXME: 直書き良くないかも
      EntitlementInfo? entitlement =
          customerInfo.entitlements.all["aizuchi_premium_subscription"];

      //dev
      // EntitlementInfo? entitlement =
      //     customerInfo.entitlements.all["offering_test_a"];
      return entitlement!.isActive;
    } on Exception {
      throw "エラーが発生しました";
    }
  }

  @override
  Future<bool> restorePurchase() async {
    try {
      CustomerInfo customerInfo = await Purchases.restorePurchases();
      //FIXME: 直書き良くないかも
      EntitlementInfo? entitlement =
          customerInfo.entitlements.all["aizuchi_premium_subscription"];

      //dev
      // EntitlementInfo? entitlement =
      //     customerInfo.entitlements.all["offering_test_a"];
      return entitlement!.isActive;
    } on Exception {
      throw "エラーが発生しました";
    } catch (e) {
      throw "エラーが発生しました";
    }
  }
}
