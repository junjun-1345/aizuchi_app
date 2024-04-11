import 'package:aizuchi_app/domain/entity/enums/plan.dart';
import 'package:aizuchi_app/domain/entity/models/plan_model.dart';
import 'package:aizuchi_app/domain/entity/models/subscription_model.dart';
import 'package:aizuchi_app/domain/repositories/purchases_flutter_repository.dart';
import 'package:aizuchi_app/domain/repositories/user_db_repository.dart';
import 'package:aizuchi_app/domain/usecases/subscription_usecase.dart';

class SubscriptionInteractor implements SubscriptionUsecases {
  final UserDBRepository userRepository;
  final PurchasesFlutterRepository purchasesFlutterRepository;

  SubscriptionInteractor(this.userRepository, this.purchasesFlutterRepository);

  @override
  Future<SubscriptionModel> checkSubscriptionStatus() async {
    return await purchasesFlutterRepository.checkSubscriptionStatus();
  }

  @override
  Future<void> configureSDK() async {
    await purchasesFlutterRepository.configureSDK();
  }

  @override
  Future<List<Plan>> getPackages() async {
    return await purchasesFlutterRepository.getPackages();
  }

  @override
  Future<bool> purchasePackage(PlanType planType) async {
    return await purchasesFlutterRepository.purchasePackage(planType);
  }

  @override
  Future<bool> restorePurchase() async {
    return await purchasesFlutterRepository.restorePurchase();
  }
}
