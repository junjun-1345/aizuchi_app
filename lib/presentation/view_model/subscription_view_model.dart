import 'package:aizuchi_app/domain/domain_module.dart';
import 'package:aizuchi_app/domain/entity/enums/plan.dart';
import 'package:aizuchi_app/domain/entity/models/plan_model.dart';
import 'package:aizuchi_app/domain/entity/models/subscription_model.dart';
import 'package:aizuchi_app/domain/usecases/subscription_usecase.dart';
import 'package:aizuchi_app/presentation/state/app_state.dart';
import 'package:aizuchi_app/presentation/state/user_providers.dart';
import 'package:aizuchi_app/presentation/state/user_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final subscriptionViewModelProvider = Provider<SubscriptionViewModel>(
  (ref) => SubscriptionViewModel(
    ref,
    ref.read(usersNotifierProvider.notifier),
    ref.read(subscriptionUsecaseProvider),
    ref.read(isWaitngProvider.notifier),
  ),
);

class SubscriptionViewModel {
  final Ref ref;
  final UsersNotifier usersNotifier;
  final SubscriptionUsecases subscriptionUsecase;
  final IsWaitngNotifier isWaitngNotifier;

  SubscriptionViewModel(this.ref, this.usersNotifier, this.subscriptionUsecase,
      this.isWaitngNotifier);

  Future<void> configureSDK() async {
    await subscriptionUsecase.configureSDK();
  }

  Future<List<Plan>> getPackages() async {
    return await subscriptionUsecase.getPackages();
  }

  Future<void> purchasePackage(PlanType planType) async {
    final bool isActive;
    try {
      isActive = await subscriptionUsecase.purchasePackage(planType);
      ref.read(userIsSubscriptionProvider.notifier).state = isActive;
      usersNotifier.isSubscriptionUpdate();
    } catch (e) {
      isWaitngNotifier.stopWaiting();
    }
  }

  Future<void> restorePurchase() async {
    isWaitngNotifier.startWaiting();
    final bool isActive = await subscriptionUsecase.restorePurchase();
    ref.read(userIsSubscriptionProvider.notifier).state = isActive;
    usersNotifier.isSubscriptionUpdate();
    isWaitngNotifier.stopWaiting();
  }

  Future<SubscriptionModel> checkSubscriptionStatus() async {
    final SubscriptionModel subscriptionStatus =
        await subscriptionUsecase.checkSubscriptionStatus();
    ref.read(userIsSubscriptionProvider.notifier).state =
        subscriptionStatus.isActive;
    usersNotifier.isSubscriptionUpdate();
    return subscriptionStatus;
  }
}
