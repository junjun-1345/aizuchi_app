import 'package:aizuchi_app/domain/domain_module.dart';
import 'package:aizuchi_app/domain/usecases/remote_config_usecase.dart';
import 'package:aizuchi_app/domain/usecases/subscription_usecase.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

final configViewModelProvider = Provider<ConfigViewModel>(
  (ref) => ConfigViewModel(
    ref,
    ref.read(subscriptionUsecaseProvider),
    ref.read(remoteConfigUsecaseProvider),
  ),
);

class ConfigViewModel {
  final Ref ref;
  final SubscriptionUsecases subscriptionUsecases;
  final RemoteConfgUsecase remoteConfgUsecase;

  ConfigViewModel(
    this.ref,
    this.subscriptionUsecases,
    this.remoteConfgUsecase,
  );

  Future<void> initialConfig() async {
    await ref.read(subscriptionUsecaseProvider).configureSDK();
    await ref.read(remoteConfigUsecaseProvider).congigFRC();
  }
}
