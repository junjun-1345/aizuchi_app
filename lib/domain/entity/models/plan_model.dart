import 'package:aizuchi_app/domain/entity/enums/plan.dart';

class Plan {
  final String id;
  final String name;
  final int price;
  final PlanType planType;

  Plan({
    required this.id,
    required this.name,
    required this.price,
    required this.planType,
  });
}
