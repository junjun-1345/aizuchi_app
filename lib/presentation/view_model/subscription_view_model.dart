import 'package:aizuchi_app/domain/domain_module.dart';
import 'package:aizuchi_app/domain/entity/enums/plan.dart';
import 'package:aizuchi_app/domain/entity/models/plan_model.dart';
import 'package:aizuchi_app/domain/entity/models/subscription_model.dart';
import 'package:aizuchi_app/domain/usecases/app_usecase.dart';
import 'package:aizuchi_app/presentation/state/app_state.dart';
import 'package:aizuchi_app/presentation/state/user_providers.dart';
import 'package:aizuchi_app/presentation/state/user_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final subscriptionViewModelProvider = Provider<SubscriptionViewModel>(
  (ref) => SubscriptionViewModel(
    ref,
    ref.read(usersNotifierProvider.notifier),
    ref.read(appUsecaseProvider),
    ref.read(isWaitngProvider.notifier),
  ),
);

class SubscriptionViewModel {
  final Ref ref;
  final UsersNotifier usersNotifier;
  final AppUsecase appUsecase;
  final IsWaitngNotifier isWaitngNotifier;

  SubscriptionViewModel(
    this.ref,
    this.usersNotifier,
    this.appUsecase,
    this.isWaitngNotifier,
  );

  Future<List<Plan>> getPackages() async {
    return await appUsecase.getSubscriptionPackages();
  }

  Future<void> purchasePackage(PlanType planType) async {
    final bool isActive;
    try {
      isActive = await appUsecase.purchaseSubscriptionPackage(planType);
      ref.read(userIsSubscriptionProvider.notifier).state = isActive;
      // usersNotifier.isSubscriptionUpdate();
    } catch (e) {
      isWaitngNotifier.stopWaiting();
    }
  }

  Future<void> restorePurchase() async {
    isWaitngNotifier.startWaiting();
    final bool isActive = await appUsecase.restorePurchase();
    ref.read(userIsSubscriptionProvider.notifier).state = isActive;
    // usersNotifier.isSubscriptionUpdate();
    isWaitngNotifier.stopWaiting();
  }

  Future<SubscriptionModel> checkSubscriptionStatus() async {
    final SubscriptionModel subscriptionStatus =
        await appUsecase.checkSubscriptionStatus();
    ref.read(userIsSubscriptionProvider.notifier).state =
        subscriptionStatus.isActive;
    // usersNotifier.isSubscriptionUpdate();
    return subscriptionStatus;
  }
}
